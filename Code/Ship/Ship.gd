extends ScreenWrapper
class_name Ship

const BULLET = preload("res://Bullet/Bullet.tscn")
@onready var particles = $Particles

var main: Main = null
var thrust_power: float = 10.0
var rotation_speed: float = 180 # angle° / sec.
var velocity: Vector2 # px / sec.
var ui: UI


func _process(delta):
	super._process(delta)
	
	if Input.is_action_pressed("turn_ccw"):
		rotation_degrees -= rotation_speed * delta
	if Input.is_action_pressed("turn_cw"):
		rotation_degrees += rotation_speed * delta
	
	# Thrust.
	if Input.is_action_pressed("thrust"):
		var direction = Vector2(-cos(rotation + main.NINTY_DEGREES), sin(rotation - main.NINTY_DEGREES))
		velocity += direction * thrust_power
		particles.show()
	
	if Input.is_action_just_released("thrust"):
		particles.hide()
	
	# Fire.
	if Input.is_action_just_pressed("fire"):
		var bullet = BULLET.instantiate()
		bullet.ship = self
		bullet.position = position
		bullet.rotation = rotation - main.NINTY_DEGREES
		main.bullets.add_child(bullet)
	
	position += velocity * delta


func BlowUp():
	# TODO: Animate an explosion. Particles?
	if ui.lives <= 0:
		main.GameOver()
	
	queue_free()

