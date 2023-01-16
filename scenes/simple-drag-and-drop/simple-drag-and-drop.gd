extends Control

var _draggingNode : DraggableNode

func _ready():
	Signals.connect("StartDraggingNode", self, "StartDraggingNode")
	Signals.connect("DoneDraggingNode", self, "DoneDraggingNode")

func StartDraggingNode(draggableNode : DraggableNode):
	_draggingNode = draggableNode

func DoneDraggingNode():
	_draggingNode = null

# This is where we catch invalid drops
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.is_pressed():
		if _draggingNode:
			# Restore the original
			_draggingNode.visible = true
		DoneDraggingNode()

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()
