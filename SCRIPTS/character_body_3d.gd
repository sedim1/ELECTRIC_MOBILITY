class_name  Player
extends CharacterBody3D

enum playerStates {IDLE,MOVING,STOPPING}
var currentState : playerStates
@export var acceleration : float = 10.5
const rotSpeed = 2.5
var speed : float
var direction : Vector3
var hasBounce : bool = true
var isBoosting : bool = false

func _ready() -> void:
	direction = Vector3(1.0,0.0,0.0)
	currentState = playerStates.MOVING
	setInitialVelocity()

#For boosters
func increaseSpeed(x : float) -> void:
	#print("Old speed: " + str(speed))
	speed += x
	#print("New speed: " + str(speed))
	isBoosting = true

#Player Movement
func setInitialVelocity() -> void:
	updateDirection()
	speed = 80.0
	velocity = direction * speed
	pass

func accelerate(delta : float) -> void:
	#var horizontalVelocity : Vector3 = Vector3(velocity.x,0.0,velocity.z)
	isBoosting = false
	var at = acceleration * delta
	speed = speed+at

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

	if not is_on_floor():
		velocity += get_gravity() * delta
	elif is_on_wall():
		var objectCollided  = get_slide_collision(0).get_collider()
		#print("Object name: " + objectCollided.name)
		if objectCollided.is_in_group("Destroyable"):
			#print("Destroy object")
			if  speed >= objectCollided.minSpeed:
				objectCollided.startDestroying()
			else:
				bounceOnWall()
		else:
			#print("Wall bounce");
			bounceOnWall()
	elif isBoosting:
		accelerate(delta)
	else:
		deaccelerate(delta)
	updateDirection()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	$CHARACTER/AnimationPlayer.play("Accelerating")
	if speed <= 0:
		currentState = playerStates.STOPPING
		$CHARACTER/AnimationPlayer.play("Stopping")
	pass

#Animation Handling
func stopAnimation()-> void:
	if not $CHARACTER/AnimationPlayer.is_playing():
		currentState = playerStates.IDLE
	pass

func idleAnimation() -> void:
	$CHARACTER/AnimationPlayer.play("Idle")
	pass

#Update every frame
func _physics_process(delta: float) -> void:
	updateYAngle()
	if currentState == playerStates.IDLE:
		idleAnimation()
	elif currentState == playerStates.MOVING:
		processMovement(delta)
	elif currentState == playerStates.STOPPING:
		stopAnimation()
	move_and_slide()
		
