class_name  Player
extends CharacterBody3D

@export var acceleration : float = 10.5
const rotSpeed = 10
var speed : float
var direction : Vector3
var hasBounce : bool = true

func _ready() -> void:
	direction = Vector3(1.0,0.0,0.0)
	setInitialVelocity()

#Player Movement
func setInitialVelocity() -> void:
	updateDirection()
	speed = 50.0
	velocity = direction * speed
	pass

func deaccelerate(delta : float) -> void:
	#var horizontalVelocity : Vector3 = Vector3(velocity.x,0.0,velocity.z)
	speed = velocity.length()
	if speed > 0 and not hasBounce:
		var at = acceleration * delta
		speed = max(0,speed-at)
	else:
		hasBounce = false

#Direction Functions
func updateDirection() -> void:
	#
	var rotMat : Transform3D = Transform3D()
	var aux : Vector3 =  Vector3(1.0,0.0,0.0)
	rotMat = rotMat.rotated(Vector3.UP,rotation.y)
	direction = rotMat * aux
	direction = direction.normalized()
	pass

func bounceOnWall() -> void: #Will update the angle based on te reflection
	#Get the normal were te wall bounced
	var wallNormal : Vector3 = get_wall_normal().normalized()
	var newDir : Vector3 = direction.bounce(wallNormal).normalized()
	var aux : Vector3 = Vector3(1.0,0.0,0.0)
	var newAngle : float = acos((aux.dot(newDir))/(aux.length()*newDir.length()))
	if newDir.z > 0.0:
		newAngle *= -1
	rotation.y = newAngle 
	hasBounce = true

#Input Processing
func updateYAngle() -> void:
	if Input.is_action_pressed("left"):
		rotation_degrees.y += rotSpeed
	if Input.is_action_pressed("right"):
		rotation_degrees.y -= rotSpeed

#Final functions
func processMovement(delta : float) -> void:
	#Bounc on wall to keep the velocity and not stop
	if is_on_wall():
		var objectCollided : Object = get_last_slide_collision().get_collider(2)
		print("Object name: "+objectCollided.name)
		if objectCollided.is_in_group("Destroyable") :
			print("Destroy object")
			objectCollided.startDestroying()
		else:
			print("Wall bounce");
			bounceOnWall()
	else:
		deaccelerate(delta)
	updateDirection()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	if not is_on_floor():
		velocity += get_gravity() * delta
	print("Speed: " + str(speed) + " m/s")
	move_and_slide()
	pass

#Update every frame
func _physics_process(delta: float) -> void:
	updateYAngle()
	processMovement(delta)
