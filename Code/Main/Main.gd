extends Node
class_name Main

const ROCK = preload("res://Rock/Rock.tscn")
const UFO = preload("res://UFO/UFO.tscn")


@onready var player = $Player

# Sapwn into these nodes.
@onready var gameplay = $Gameplay 
@onready var rocks = $Rocks

@onready var ufo_timer = $UFOTimer

@onready var main_menu = $MainMenu
@onready var play_button = $MainMenu/VBox/PlayButton
@onready var continue_button = $MainMenu/VBox/ContinueButton
@onready var quit_button = $MainMenu/VBox/QuitButton

var radius: float = 200
var starting_count: int = 3 # Adds another rock on play.
var rock_count: int = starting_count



func _ready():
	# Hook up signals.
	ufo_timer.timeout.connect(OnSpawnUFO)
	play_button.pressed.connect(OnPlayPressed)
	continue_button.pressed.connect(OnContinuePressed)
	quit_button.pressed.connect(OnQuitPressed)
	
	OnContinuePressed() # Hide the correct buttons.
	main_menu.show()
	


func _process(delta):
	# Is the game over?
	if player.lives <= 0 and player.ship == null:
		main_menu.show()
	
	# Is the level over?
	if rocks.get_child_count() <= 0 and not main_menu.visible:
		SpawnRocks(rock_count)
		rock_count += 1
	
	# Pause.
	if Input.is_action_just_pressed("pause"):
		main_menu.show()
		play_button.hide()
		continue_button.show()
		get_tree().paused = true

	
	#if rocks_list.is_empty():
		#SpawnRocks(rock_count)
		#rock_count += 1

func ResetLevel():
	# Player
	player.lives = 0
	player.UpdateLives(3)
	player.score = 0
	player.UpdateScore(0)
	
	# Rocks.
	rock_count = starting_count
	Dev.RemoveChildrenOf(rocks)
	SpawnRocks(rock_count)


func SpawnRocks(count: int):
	for i in count:
		var rock = ROCK.instantiate()
		rock.position = RandomPointOnCircle(radius)
		rock.position += get_viewport().size / 2.0 # Needs to be a float.
		rocks.add_child(rock)


func RandomPointOnCircle(radius: float) -> Vector2:
	var angle: float = randf_range(0.0, PI * 2.0)
	return Vector2(sin(angle) * radius, cos(angle) * radius)


func OnSpawnUFO():
	var ufo = UFO.instantiate()
	gameplay.add_child(ufo)
	#ufo_timer.wait_time *= 0.5

func OnContinuePressed():
	play_button.show()
	continue_button.hide()
	main_menu.hide()
	get_tree().paused = false



func OnPlayPressed():
	main_menu.hide()
	ResetLevel()
	SpawnRocks(rock_count)
	print("Start playing.")


func OnQuitPressed():
	get_tree().quit()
