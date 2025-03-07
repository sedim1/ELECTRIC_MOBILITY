class_name CameraPath
extends Path3D

@onready var point : PathFollow3D = $PathFollow3D
@onready var camera : Camera3D = $PathFollow3D/Camera3D
@export var speed : float = 0.5

var isFinished : bool = false
var start : bool = false

func disableCamera()->void:
    camera.current = false
    pass

func enableCamera()->void:
    camera.current = true
    pass

func _process(delta: float) -> void:
    if not isFinished and start:
        point.progress_ratio += speed * delta
        if point.progress_ratio >= 1.0:
            point.progress_ratio = 1.0
            isFinished = true
    pass

