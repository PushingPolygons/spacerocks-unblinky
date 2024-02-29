extends ScreenWrapper
class_name Ship

const BULLET = preload("res://Projectile/Projectile.tscn")

var player: Player
var thrust_multiplier: float = 15.0

# TODO: Make UFO bullet 

func _ready():
	area_entered.connect(OnAreaEntered)

func _process(delta):
	super._process(delta)
	
	# Navigation.
	if Input.is_action_pressed("rotate_cw"):
		rotation_degrees -= 360 * delta
	if Input.is_action_pressed("rotate_ccw"):
		rotation_degrees += 360 * delta
	
	# Move Forward.
	if Input.is_action_pressed("thrust"):
		var direction = Vector2(cos(-rotation), sin(rotation))
		velocity += direction * thrust_multiplier
		#print("thrust: ", velocity)
	
	# Update the position
	position += velocity * delta
	
	# Fire.
	if Input.is_action_just_pressed("fire"):
		var bullet = BULLET.instantiate()
		bullet.player = player
		bullet.position = position
		bullet.rotation = rotation
		get_parent().add_child(bullet)
		#print("Fire!")

func Destroy():
	queue_free()


func OnAreaEntered(other_area: Area2D):
	if other_area is Bullet:
		if not other_area.player:
			other_area.Destroy()
			Destroy()
	
	if other_area is UFO:
		other_area.queue_free()
		player.UpdateScore(other_area.point_count)
		Destroy()
