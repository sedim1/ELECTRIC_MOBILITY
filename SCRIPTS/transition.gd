class_name  Transition
extends CanvasLayer

@onready var color_rect : ColorRect = $ColorRect
@onready var animation_player : AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#animation_player.animation_finished.connect(_on_animation_finished)


func transitionStart():
	animation_player.play("FadeIn")

func transitionFadeToBlack():
	animation_player.play("FadeOut")

