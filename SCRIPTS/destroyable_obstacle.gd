class_name AutoDestroy
extends StaticBody3D

@export var minSpeed : float = 0.0 #Minimu speed that this object needs to be destroyed
@onready var collisionShape : CollisionShape3D = $Collider
@onready var destroyedSound : AudioStreamPlayer = $DestroyedSound
@onready var shapeModel : Node3D = $Asteroid
enum objectState {IDLE,CRUMBLE,DESTROYED}
var state : objectState

func _ready() -> void:
	state = objectState.IDLE
	pass

func startDestroying() -> void:
	state = objectState.CRUMBLE
	collisionShape.disabled = true
	shapeModel.visible = false
	destroyedSound.play()
	pass

func playParticlesDestruction() -> void:
	if not destroyedSound.playing:
		state = objectState.DESTROYED
	pass

func dissapear() -> void:
	queue_free()
	pass

func _physics_process(delta: float) -> void:
	if state == objectState.IDLE:
		pass
	elif state == objectState.CRUMBLE:
		playParticlesDestruction()
	if state == objectState.DESTROYED:
		dissapear()
	pass
