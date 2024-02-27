extends ScreenWrapper
class_name Rock

# E 0:00:00:0642   set_path: Another resource is loaded from path 'res://Rock/Rock.tscn' (possible cyclic resource inclusion).
#const ROCK = preload("res://Rock/Rock.tscn")

@onready var sprites = $Sprites

#@export var velocity: Vector2 = Vector2(300, -150) # per / sec.
var thrust_multiplier = 200


func _ready():
	area_entered.connect(OnAreaEntered)
	
	velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	velocity *= thrust_multiplier
	sprites.frame = randi_range(0, 4)


func _process(delta):
	super._process(delta)
	position += velocity * delta


func Destroy():
	if scale.x > 0.25:
		# Spawn 2 smaller rocks.
		for r in 2:
			var new_rock = duplicate()
			new_rock.scale *= 0.5
			get_parent().call_deferred("add_child", new_rock)
	
	queue_free()


func OnAreaEntered(other_area: Area2D):
	if other_area is Bullet:
		if other_area.player:
			other_area.player.UpdateScore(20)
		
		other_area.Destroy()
		Destroy()

	
	if other_area is Ship:
		other_area.Destroy()
		other_area.player.UpdateScore(-100) # TODO: Is this fun?
		Destroy()
