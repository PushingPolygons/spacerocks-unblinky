extends ScreenWrapper
class_name Rock

@onready var animated_sprite_2d = $AnimatedSprite2D

var main: Main
var speed: float = randf_range(70, 350)
var direction: Vector2 = Vector2(randf_range(-1, 1), randf_range(-1, 1))
var rotation_speed: float = randf_range(-180, 180) # angle.
var score_value: int = 2


func _ready():
	animated_sprite_2d.frame = randi_range(0, animated_sprite_2d.sprite_frames.get_frame_count("default") - 1)
	area_entered.connect(OnAreaEntered)


func _process(delta):
	super._process(delta) # Handle wrapping.
	position += direction * speed * delta
	rotation_degrees += rotation_speed * delta


func Shatter(count: int):
	if self.scale.x > 0.25:
		for r in count:
			var small_rock = self.duplicate()
			small_rock.main = self.main
			small_rock.position = self.position
			small_rock.scale *= 0.5
			main.rocks.call_deferred("add_child", small_rock)


func OnAreaEntered(other_area):
	if other_area is Bullet:
		other_area.ship.ui.UpdateScore(score_value)
		other_area.queue_free()
		Shatter(2)
		queue_free()
	
	if other_area is Ship:
		other_area.BlowUp()
		Shatter(3)
		queue_free()
	
