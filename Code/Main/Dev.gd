extends Node
class_name Dev

static func RemoveChildrenOf(node: Node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()


static func RandomPointOnCircle(radius: float) -> Vector2:
	var angle: float = randf_range(0.0, PI * 2.0)
	return Vector2(sin(angle) * radius, cos(angle) * radius)
  
# var x: float = sin(angle) * radius
# var y: float = cos(angle) * radius
