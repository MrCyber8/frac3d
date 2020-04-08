extends KinematicBody

export var speed = 12
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sens = 0.3

onready var head = $Head
onready var camera = $Head/Camera

var velocity = Vector3()
var camera_x_rotation = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sens))
		


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	
	var direction = Vector3()
	if Input.is_action_pressed("move_fwd"):
		direction -= head_basis.z 
	elif Input.is_action_pressed("move_bwd"):
		direction += head_basis.z 
	
	if Input.is_action_pressed("move_lft"):
		direction -= head_basis.x 
	elif Input.is_action_pressed("move_rgt"):
		direction += head_basis.x 
		
	direction = direction.normalized()
	
	velocity = direction * speed
	
	
	if Input.is_action_pressed("move_up") and is_on_floor():
		velocity.y += jump_power
	
	velocity = move_and_slide(velocity, Vector3.UP)

	





