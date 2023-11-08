extends Node
class_name Main

const UI_SCENE = preload("res://UI/UI.tscn")
const ROCK = preload("res://Rock/Rock.tscn")

@onready var rocks = $Rocks
@onready var bullets = $Bullets
@onready var ships = $Ships
@onready var ship_list = $MainData/ShipList
@onready var main_menu = $MainMenu
@onready var message = $MainMenu/VBox/Message
@onready var play_button = $MainMenu/VBox/PlayButton
@onready var quit_button = $MainMenu/VBox/QuitButton
@onready var restart_button = $MainMenu/VBox/RestartButton


func _ready():
	# Signal Hookups.
	play_button.pressed.connect(OnPlayPressed)
	restart_button.pressed.connect(OnRestartPressed)
	quit_button.pressed.connect(OnQuitPressed)
	
	# Initalize Main Menu.
	main_menu.show()
	play_button.show()
	restart_button.hide()
	quit_button.show()
	message.text = "Space Rocks!"
	SpawnRocks(3)


func OnRestartPressed():
	get_tree().reload_current_scene()


# TODO: Handle multi-ship games.
#func _process(delta):
#	# HACK: Is there a reason to check this every frame?
#	if ships.get_child_count() <= 0:
#		GameOver()


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


# TODO: Change to SpawnUI().
func SpawnUI():
	var ui = UI_SCENE.instantiate()
	ui.main = self
	ship_list.add_child(ui)

# TODO: Spawn initial Rocks.
