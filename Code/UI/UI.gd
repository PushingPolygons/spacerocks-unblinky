extends PanelContainer
class_name UI

const LIFE = preload("res://UI/assets/life.tscn")
const SHIP = preload("res://Ship/Ship.tscn")

@onready var score_ui = $VBox/ScoreUI
@onready var lives_list = $VBox/LivesList


var main: Main
var score: int = 0
var lives: int = 0
var ship: Ship

func _ready():
	UpdateLives(3)


func _process(delta):
	if Input.is_action_just_pressed("spawn_ship"):
		SpawnShip()


func SpawnShip():
	if not ship:
		ship = SHIP.instantiate()
		ship.ui = self
		ship.main = main
		ship.position = get_viewport().size / 2
		main.ships.add_child(ship)
		UpdateLives(-1)


func UpdateScore(delta_score):
	score += delta_score
	score_ui.text = str(score)


func UpdateLives(delta_lives):
	lives += delta_lives
	# HACK: if lives <= -1: # Does this work?
		# TODO: main.GameOver()
	
	if lives >= 0:
		# Removing all children.
		for child in lives_list.get_children():
			lives_list.remove_child(child)
			child.queue_free()
		
		# Adding the lives back. 
		for i in lives:
			lives_list.add_child(LIFE.instantiate())
