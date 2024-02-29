extends Node
class_name Dev

static func RemoveChildrenOf(node: Node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
