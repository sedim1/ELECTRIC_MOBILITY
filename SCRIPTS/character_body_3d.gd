class_name  Player
extends CharacterBody3D

@export var acceleration : float = 10.5
const initialSpeed : float = 90.0
const rotSpeed = 0.05
var speed : float
var direction : Vector3

func _ready() -> void:
	direction = Vector3(1.0,0.0,0.0)
	setInitialVelocity()

#Player Movement
func setInitialVelocity() -> void:
	updateDirection()
	velocity = direction * initialSpeed
	pass

func deaccelerate(delta : float) -> void:
	speed = velocity.length()
	if speed > 0:
		var deacceleration = acceleration * delta
		speed = max(0,speed-deacceleration)
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	print("Velocity: " + str(speed) + "m/s")


func updateDirection() -> void:
	#
	var rotMat : Transform3D = Transform3D()
	var aux : Vector3 =  Vector3(1.0,0.0,0.0)
	rotMat = rotMat.rotated(Vector3.DOWN,rotation.y)
	direction = aux *  rotMat
	pass

func updateYAngle() -> void:
	if Input.is_action_pressed("left"):
		rotation.y += rotSpeed
		if rotation.y > 360:
			rotation.y = fmod(rotation.y,360)
	if Input.is_action_pressed("right"):
		rotation.y -= rotSpeed
		if rotation.y < -360:
			rotation.y = fmod(rotation.y,-360)
	pass

func processMovement(delta : float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	updateDirection()
	deaccelerate(delta)
	#print("Direction: " + str(direction))
	move_and_slide()
	pass

#Update every frame
func _physics_process(delta: float) -> void:
	updateYAngle()
	processMovement(delta)