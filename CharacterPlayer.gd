extends CharacterBody3D

const SENSITIVITY = 0.002
"  SENSIVITY_CAMERA"
var damage = 10
"  WEAPON_DAMAGE"
const VELOCITY_ACCELERATION = 50.0
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var gravity = 16.5
"  Physic configuration"

@onready var head = "Your Head"
@onready var camera = "Your Câmera"
@onready var anim_player = "Your Animations"
@onready var raycast = "Your Raycast"
"  Physical sets"

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-70), deg_to_rad(89))

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
  
"  Camera_motion"

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
"  Move and physics function"
  

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
" FIRE_WEAPON_FUNCTION"

	move_and_slide()
	
