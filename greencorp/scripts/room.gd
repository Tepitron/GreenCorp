extends Node3D

@onready var ray_cast_3d: RayCast3D = $Player/TwistPivot/PitchPivot/Camera3D/RayCast3D
@onready var corkboard_area_3d = $Interior/Room/CorkBoard/CorkBoardArea3D
@onready var corkboard_camera = $Interior/Room/CorkBoard/Camera3D
@onready var player_camera = $Player/TwistPivot/PitchPivot/Camera3D
@onready var player = $Player


var raycast_collided_with

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect corkboard's signal to know if exit button has been clicked
	$Interior/Room/CorkBoard.exit_clicked.connect(_on_corkboard_exit_clicked)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print_debug(player.position)
	pass

func _physics_process(delta: float) -> void:
	# Get raycast's collision from player
	raycast_collided_with = ray_cast_3d.get_collider()
	
# Handle inputs
# On escape -> Mouse is free to move
# On left click -> Check if player is looking at an interactable object
# 				   and call the attached function
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("left_click"):
		print_debug("Left click clicked")
		print_debug(raycast_collided_with)
		if raycast_collided_with == corkboard_area_3d:
			print_debug("Corkboard clicked")
			on_corkboard_clicked()

# Called when the player clicks the corkboard 
func on_corkboard_clicked():
	# Switch to the corkboard's camera
	corkboard_camera.current = true
	player.activate_interaction_mode()
	$Interior/Room/CorkBoard/ExitButton.show()
	
# Called when the player clicks the exit button in the corkboard view
func _on_corkboard_exit_clicked():
	player.activate_freeroam_mode()
	# Switch to the player's pov camera
	player_camera.current = true
	$Interior/Room/CorkBoard/ExitButton.hide()
