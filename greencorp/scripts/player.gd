extends CharacterBody3D

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var raycast     := $TwistPivot/PitchPivot/Camera3D/RayCast3D
@onready var crosshair := $UI/TextureRect

var mouse_sensitivity := 0.005
var twist_input := 0.0
var pitch_input := 0.0
var is_frozen := false
var freeroam_mode := true

const SPEED = 5.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta: float) -> void:
	
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x, 
		-1.0, 
		0.7
	)
	twist_input = 0.0
	pitch_input = 0.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector(
		"move_left", "move_right", 
		"move_forward", "move_backward")
		
	var direction = (
		twist_pivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(
	)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if !is_frozen:
		move_and_slide()
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity

func activate_interaction_mode():
	#Hides the player character
	hide()
	# Freezes the player in place to prevent movement
	is_frozen = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	#raycast.set_enabled(false)
	crosshair.hide()
	freeroam_mode = false
	
func activate_freeroam_mode():
	# Shows the player character
	show()
	# Unfreezes the player
	is_frozen = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#raycast.set_enabled(true)
	raycast.clear_exceptions()
	crosshair.show()
	freeroam_mode = true
	
func is_in_freeroam_mode():
	return freeroam_mode 
