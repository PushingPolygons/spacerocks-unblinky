extends ScreenWrapper
class_name UFO

const BULLET = preload("res://Bullet/Bullet.tscn")

@onready var change_course_timer = $ChangeCourseTimer
@onready var fire_timer = $FireTimer

# Set from Main.
var main: Main
var direction_x: int

var speed_x: float = 100.0
var speed_y: float = 0
var y_speeds: Array[float] = [100.0, -100.0]


func _ready():
	change_course_timer.timeout.connect(ChangeCourse)
	fire_timer.timeout.connect(Fire)
	lock_sides = true
	
	# Set starting positions.
	position.y = randf_range(0, get_viewport().size.x)
	if direction_x < 0:
		position.x = get_viewport().size.x
	else:
		position.x = 0
	
	# Set speed.
	speed_x *= direction_x


func _process(delta):
	super._process(delta)
	position.x += speed_x * delta
	position.y += speed_y * delta
	
	if position.x < 0:
		queue_free()
	elif position.x > get_viewport().size.x:
		queue_free()


func ChangeCourse():
	if speed_y == 0:
		speed_y = y_speeds[randi_range(0, y_speeds.size() - 1)]
	else:
		speed_y = 0


func Fire():
	var bullet = BULLET.instantiate()
	bullet.ship = null
	bullet.position = position
	bullet.rotation_degrees = randf_range(-180, 180)
	bullet.scale *= 0.5
	main.bullets.add_child(bullet)
