extends Control
class_name DraggableNode

onready var _textureButton = $CenterContainer/TextureButton
export var _nodeType : String = "triangle"

func _ready():
	_textureButton.texture_normal  = load("res://assets/shapes/" + _nodeType + "-128x128.png")

func GetDropType():
	return _nodeType

func RestoreNode():
	visible = true

func get_drag_data(_position : Vector2):
	# Store self in a dictionary
	var data = {}
	data["DraggableNode"] = self
	
	# Duplicate myself for the preview
	var draggableNode = self.duplicate()
	
	# Create a temporary drag preview control that will free itself 
	var dragPreview = Control.new()

	# Add our duped self. You can use any scene as the preview. You don't
	# have to duplicate and in some cases, that can be problematic. If duplicate
	# is giving you a hard time, create an all new node of this type or a spoof one.
	# Only has to look like your node.
	dragPreview.add_child(draggableNode)
	
	# Tweak the preview so it's centered on our mouse and partially opaque.
	draggableNode.rect_position = -0.5 * draggableNode.rect_size
	draggableNode.modulate = Color(1.0, 1.0, 1.0, 0.3)
	
	set_drag_preview(dragPreview)
	
	# Couple ways to do this depending on your needs. You can remove
	# it from the scene tree and store it temporarily or you can hide it.
	# Hiding is easier because we can easily restore it by making it 
	# visible again in-case the user cancels or makes an invalid drop.
	visible = false
	
	Signals.emit_signal("StartDraggingNode", self)
	return data
