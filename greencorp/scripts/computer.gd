extends StaticBody3D
@onready var camera_3d: Camera3D = $Camera3D
var computer_2d_scene = preload("res://scenes/computer_2d.tscn")

var camera_animation_active = false
var camera_animation_offset = Vector3(-0.85,0,-1)
var camera_starting_position
var camera_starting_rotation
const CAMERA_ANIMATION_LIMIT = 0.4
const CAMERA_ROTATION_OFFSET = 0.3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_starting_position = camera_3d.position
	camera_starting_rotation =  camera_3d.rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if camera_animation_active:
		drive_camera_closer(delta)

func drive_camera_closer(delta: float):
	camera_3d.position += camera_animation_offset * delta
	camera_3d.rotate_x(CAMERA_ROTATION_OFFSET * delta)
	if camera_3d.position.z <= camera_starting_position.z - CAMERA_ANIMATION_LIMIT:
		camera_animation_active = false
		reset_camera()
		get_tree().change_scene_to_packed(computer_2d_scene)
		
func begin_camera_animation():
	camera_animation_active = true

func reset_camera():
	camera_3d.position = camera_starting_position
	camera_3d.rotation = camera_starting_rotation
	
