extends Node
class_name Main

const UI_SCENE = preload("res://UI/UI.tscn")
const ROCK = preload("res://Rock/Rock.tscn")
const UFO_SCENE = preload("res://UFO/UFO.tscn")

@onready var rocks = $Rocks
@onready var bullets = $Bullets
@onready var ships = $Ships
@onready var ship_list = $MainData/ShipList
@onready var main_menu = $MainMenu
@onready var message = $MainMenu/VBox/Message
@onready var play_button = $MainMenu/VBox/PlayButton
@onready var quit_button = $MainMenu/VBox/QuitButton
@onready var restart_button = $MainMenu/VBox/RestartButton
@onready var ufos = $UFOs
@onready var ufo_timer = $UFOTimer

var rock_count = 1


func SpawnUFO():
	var ufo = UFO_SCENE.instantiate()
	if randi() % 2:
		ufo.direction_x = -1
	else:
		ufo.direction_x = 1
	
	ufos.add_child(ufo)


func _ready():
	# Signal Hookups.
	play_button.pressed.connect(OnPlayPressed)
	restart_button.pressed.connect(OnRestartPressed)
	quit_button.pressed.connect(OnQuitPressed)
	ufo_timer.timeout.connect(SpawnUFO)
	
	# Initalize Main Menu.
	main_menu.show()
	play_button.show()
	restart_button.hide()
	quit_button.show()
	message.text = "Space Rocks!"
	SpawnRocks(rock_count)


func _process(delta):
	var count = rocks.get_child_count()
	if count <= 0:
		rock_count += 1
		SpawnRocks(rock_count)


func OnRestartPressed():
	get_tree().reload_current_scene()


# TODO: Wishlist: Handle multi-ship games.



func SpawnRocks(count: int):
	for r in count:
		var rock = ROCK.instantiate()
		rock.main = self
		rock.position = get_viewport().size / 2
		rocks.add_child(rock)


func GameOver():
	print("Game Over!")
	main_menu.show()
	message.text = "Game Over!"
	restart_button.show()
	play_button.hide()


func OnPlayPressed():
	main_menu.hide()
	SpawnUI()


func OnQuitPressed():
	get_tree().quit()


func SpawnUI():
	var ui = UI_SCENE.instantiate()
	ui.main = self
	ship_list.add_child(ui)


# Triggered by Rock.area_entered() Signal.
#func CountRocks():
#	var count = rocks.get_child_count() - 1
#	print(count)
#
#	# Launch next level.
#	if count <= 0:
#		rock_count += 1
#		call_deferred("SpawnRocks", rock_count)
