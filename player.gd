extends CharacterBody3D

const SENSITIVITY = 0.002

var damage = 10

const VELOCITY_ACCELERATION = 50.0
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var gravity = 16.5


@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var anim_player = $AnimationPlayer
@onready var raycast = $Head/Camera3D/RayCast3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-70), deg_to_rad(89))


func _physics_process(delta):

	fire()

	if not is_on_floor():
		velocity.y -= gravity * delta


	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * VELOCITY_ACCELERATION * delta
		velocity.z = direction.z * SPEED * VELOCITY_ACCELERATION * delta
	else:
		velocity.x = 0.0
		velocity.z = 0.0
		
		
func fire():
	if Input.is_action_just_pressed("fire"):
		if not anim_player.is_playing():
			if raycast.is_colliding():
				var  target = raycast.get_collide()
				if target.is_in_group("Enemy"):
					target.health -= damage
		anim_player.play("Fire")
	else:
		anim_player.stop()

	move_and_slide()
	
