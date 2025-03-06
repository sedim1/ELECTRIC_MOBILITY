extends CanvasLayer

@onready var color_rect : ColorRect = $ColorRect
@onready var animation_player : AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	#animation_player.animation_finished.connect(_on_animation_finished)



func transitionFadeToBlack():
	color_rect.visible = true
	animation_player.play("FadeToBlack")
	pass

