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


func _ready():
	main_menu.show()
	play_button.pressed.connect(OnPlayPressed)
	quit_button.pressed.connect(OnQuitPressed)
	SpawnRocks(3)



#
#func _process(delta):
#	# HACK: Is there a reason to check this every frame?
#	if ships.get_child_count() <= 0:
#		# HACK: make a `Game Over` function.
#		main_menu.show() 


func Shatter(count: int, position: Vector2):
	for r in count:
		var small_rock = ROCK.instantiate()
		small_rock.position = position
		small_rock.scale *= 0.5
		get_parent().add_child(small_rock)


func SpawnRocks(count: int):
	for r in count:
		var rock = ROCK.instantiate()
		rock.main = self
		rock.position = get_viewport().size / 2
		rocks.add_child(rock)


func GameOver():
	print("Game Over!")


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
