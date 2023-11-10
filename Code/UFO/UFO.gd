extends Area2D
class_name UFO

@onready var change_course_timer = $ChangeCourseTimer

# Set from Main.
var direction_x: int

var speed_x: float = 100.0
var speed_y: float = 0
var y_speeds: Array[float] = [100.0, -100.0, 50.0, -50.0]


func _ready():
	change_course_timer.timeout.connect(ChangeCourse)
	
	# Set starting positions.
	position.y = randf_range(0, get_viewport().size.x)
	if direction_x < 0:
		position.x = get_viewport().size.x
	else:
		position.x = 0
	
	# Set speed.
	speed_x *= direction_x


func _process(delta):
	position.x += speed_x * delta
	position.y += speed_y * delta


func ChangeCourse():
	if speed_y == 0:
		speed_y = y_speeds[randi_range(0, y_speeds.size() - 1)]
	else:
		speed_y = 0

