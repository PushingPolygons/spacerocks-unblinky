extends ScreenWrapper
class_name Bullet

@onready var timer = $Timer

var ship: Ship

var thrust_multiplier: float = 800
var direction: Vector2


func _ready():
	timer.timeout.connect(OnTimedOut)
	direction = Vector2(cos(-rotation), sin(rotation))
	velocity += direction * thrust_multiplier


func _process(delta):
	super._process(delta)
	position += velocity * delta
	#position.x += 200 * delta


func OnTimedOut():
	Destroy()


func Destroy():
	queue_free()
