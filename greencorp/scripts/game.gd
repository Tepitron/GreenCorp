extends Node3D

@onready var ray_cast_3d: RayCast3D = $Player/TwistPivot/PitchPivot/Camera3D/RayCast3D
@onready var corkboard_area_3d = $Interior/Room/CorkBoard/CorkBoardArea3D
@onready var corkboard_camera = $Interior/Room/CorkBoard/Camera3D
@onready var player_camera = $Player/TwistPivot/PitchPivot/Camera3D
@onready var corkboard = $Interior/Room/CorkBoard
@onready var computer = $Interior/Room/Computer
@onready var computer_screen = $Interior/Room/Computer/ScreenArea3D
@onready var computer_camera = $Interior/Room/Computer/Camera3D
@onready var post_it_pile = $Interior/Room/PostItPile
@onready var player = $Player

const POST_IT = preload("res://scenes/post_it.tscn")
#const COMPUTER_2D = preload("res://scenes/computer_2d.tscn")

var raycast_collided_with

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print_debug(player.position)
	pass

func _physics_process(_delta: float) -> void:
	# Get raycast's collision from player
	raycast_collided_with = ray_cast_3d.get_collider()
# Handle inputs
# On escape -> Mouse is free to move
# On left click -> Check if player is looking at an interactable object
# 				   and call the attached function
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		activate_pausemenu(event)
	elif event.is_action_pressed("left_click") && not $PauseMenu.is_active:
		print_debug("Left click")
		if player.is_in_freeroam_mode():
			print_debug(raycast_collided_with)
			if raycast_collided_with == corkboard_area_3d:
				print_debug("Corkboard clicked")
				on_corkboard_clicked()
			if raycast_collided_with == computer_screen:
				print_debug("Computer clicked")
				on_computer_clicked()
			if raycast_collided_with == post_it_pile:
				print_debug("Post it pile clicked")
				pickup_post_it()
		else:
			activate_computer_2D_scene()
			
	elif event.is_action_pressed("cancel"):
		print_debug("Cancel pressed")
		_on_cancel_pressed()
	
# Called when the player clicks the corkboard 
func on_corkboard_clicked():
	# Switch to the corkboard's camera
	corkboard_camera.current = true
	player.activate_interaction_mode()

func on_computer_clicked():
	computer_camera.current = true
	ray_cast_3d.add_exception(raycast_collided_with)
	player.activate_interaction_mode()

func _on_cancel_pressed():
	player.activate_freeroam_mode()
	player_camera.current = true

func pickup_post_it():
	var post_it = POST_IT.instantiate()
	post_it.position = player.position 
	player_camera.add_child(post_it)

func activate_computer_2D_scene():
	computer.begin_camera_animation()
	#get_tree().change_scene_to_packed(COMPUTER_2D)

func activate_pausemenu(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$PauseMenu.show()
	$PauseMenu.set_active(true)
