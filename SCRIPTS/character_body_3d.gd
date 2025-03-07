class_name Player
extends CharacterBody3D

enum playerStates {IDLE,MOVING,STOPPING,SHOWCASE}
var currentState : playerStates
@export var acceleration : float = 10.5
@onready var collider : CollisionShape3D = $CollisionShape3D
@onready var rays : Node3D = $Rays
@onready var lostAudio : AudioStreamPlayer = $LostSound

const rotSpeed = 5
var speed : float
var direction : Vector3
var hasBounce : bool = true
var isBoosting : bool = false

func _ready() -> void:
	direction = Vector3(1.0,0.0,0.0)
	currentState = playerStates.IDLE

#For boosters
func increaseSpeed(x : float) -> void:
	#print("Old speed: " + str(speed))
	speed += x
	#print("New speed: " + str(speed))
	isBoosting = true

#Player Movement
func setInitialVelocity() -> void:
	collider.disabled = false
	updateDirection()
	speed = 80.0
	velocity = direction * speed
	currentState = playerStates.MOVING
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
	collider.disabled = true
	if newDir.z > 0.0:
		newAngle *= -1
	rotation.y = newAngle 
	hasBounce = true

#Input Processing
func updateYAngle() -> void:
	if currentState !=  playerStates.IDLE or currentState == playerStates.SHOWCASE:
		if Input.is_action_pressed("left"):
			rotation_degrees.y += rotSpeed
		if Input.is_action_pressed("right"):
			rotation_degrees.y -= rotSpeed
		pass

#Final functions
func processMovement(delta : float) -> void:

	#if not is_on_floor():
		#velocity += get_gravity() * delta
	collider.disabled = false
	if is_on_wall():
		var objectCollided  = get_slide_collision(0).get_collider()
		#print("Object name: " + objectCollided.name)
		if objectCollided.is_in_group("Destroyable"):
			#print("Destroy object")
			if  speed >= objectCollided.minSpeed:
				objectCollided.startDestroying()
			else:
				if canBounce():
					bounceOnWall()
		else:
			bounceOnWall()
	elif isBoosting:
		accelerate(delta)
	else:
		deaccelerate(delta)
	updateDirection()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	$Robot/CHARACTER/AnimationPlayer.play("Accelerating")
	if speed <= 0:
		$Robot/CHARACTER/AnimationPlayer.play("Stopping")
		lostAudio.play()
		currentState = playerStates.STOPPING
	pass

#Animation Handling
func stopAnimation()-> void:
	if not $Robot/CHARACTER/AnimationPlayer.is_playing():
		currentState = playerStates.IDLE
	pass

func idleAnimation() -> void:
	$Robot/CHARACTER/AnimationPlayer.play("Idle")
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
		
func canBounce() -> bool:
	for ray : RayCast3D in rays.get_children():
		if ray.is_colliding():
			return true
	return false