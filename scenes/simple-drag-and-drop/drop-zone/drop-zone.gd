extends Control

export var _dropType : String = ""

onready var _textureButton = $CenterContainer/TextureButton
onready var _particles = $ParticleContainer/Particles2D
onready var _particleTimer = $TimerContainer/ParticleTimer

func _ready():
	_textureButton.texture_normal = load("res://assets/shapes/" + _dropType + "-128x128.png")

func ConfigureDropZone(dropType : String):
	_dropType = dropType
	
func can_drop_data(_position, data):	
	if data.size() == 0:
		return
		
	if !data.has("DraggableNode"):
		return

	var draggableNode : DraggableNode = data["DraggableNode"]
	
	if _dropType != draggableNode.GetDropType():
		return
	
	return true

func drop_data(_position: Vector2, data):
	if !data.has("DraggableNode"):
		return
	
	# Get the DraggableNode back out of the dictionary
	var draggableNode = data["DraggableNode"]
	
	# Get what I need from the original node here and 
	# then clean it up unless I'm moving it or using it.
	draggableNode.queue_free()
	
	Signals.emit_signal("DoneDraggingNode")
	
	StartFireworks()

func StartFireworks():
	_particles.emitting = true
	_particleTimer.start()
	
func _on_ParticleTimer_timeout():
	_particles.emitting = false
