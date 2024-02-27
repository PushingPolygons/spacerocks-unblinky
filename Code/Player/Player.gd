extends PanelContainer
class_name Player

const LIFE = preload("res://Player/assets/life.tscn")
const SHIP = preload("res://Ship/Ship.tscn")

@onready var score_ui = $VBox/ScoreUI
@onready var lives_ui = $VBox/LivesUI

var score: int = 0
var lives: int = 0
var ship: Ship = null


func _ready():
	UpdateScore(0) # TODO: Load player score.
	UpdateLives(3)


func _process(delta):
	if Input.is_action_just_pressed("launch_ship"):
		if not ship:
			SpawnShip()
			UpdateLives(-1)


func SpawnShip():
	var ship = SHIP.instantiate()
	ship.player = self
	ship.position = get_viewport().size / 2
	get_parent().add_child(ship)
	self.ship = ship


func UpdateScore(delta_score: int):
	score += delta_score
	score_ui.text = str(score)


func UpdateLives(delta_lives: int):
	lives += delta_lives
	
	# Delete all children of LivesUI.
	RemoveChildrenOf(lives_ui)
	
	# Repopulate the lives icons.
	for l in lives:
		var life = LIFE.instantiate()
		lives_ui.add_child(life)
	
	print("Lives: ", lives)


func RemoveChildrenOf(node: Node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
