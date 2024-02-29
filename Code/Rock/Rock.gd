extends ScreenWrapper
class_name Rock

@onready var sprites = $Sprites

var thrust_multiplier = 50


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
