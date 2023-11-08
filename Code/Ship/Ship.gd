extends ScreenWrapper
class_name Ship

const BULLET = preload("res://Bullet/Bullet.tscn")
const NINTY_DEGREES = 1.5708

var main: Main = null # TODO: Needed?
var thrust_power: float = 10.0 #??
var rotation_speed: float = 180 # angle° / sec.
var velocity: Vector2 # px / sec.
var ui: UI


func _process(delta):
	super._process(delta)
	
	if Input.is_action_pressed("turn_ccw"):
		print("CCW")
		rotation_degrees -= rotation_speed * delta
	if Input.is_action_pressed("turn_cw"):
		print("CW")
		rotation_degrees += rotation_speed * delta
	
	# Thrust.
	if Input.is_action_pressed("thrust"):
		print("Thrust")
		var direction = Vector2(-cos(rotation + NINTY_DEGREES), sin(rotation - NINTY_DEGREES))
		velocity += direction * thrust_power
	
	# Fire.
	if Input.is_action_just_pressed("fire"):
		print("Fire")
		var bullet = BULLET.instantiate()
		bullet.ship = self
		bullet.position = position
		bullet.rotation = rotation - NINTY_DEGREES
		main.bullets.add_child(bullet)
	
	position += velocity * delta


func BlowUp():
	# TODO: Animate an explosion. Particles?
	queue_free()

