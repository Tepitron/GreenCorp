extends Node3D

var is_pen_in_hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_pen_in_hand = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_pen_in_hand:
		draw(delta)


func _on_area_3d_input_event(camera: Node, event: InputEvent, \
	event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("left_click") && not is_pen_in_hand:
		print_debug("Begin drawing")
		begin_drawing()

func begin_drawing():
	is_pen_in_hand = true

func draw(delta):
	print_debug("Mouse position", get_viewport().get_mouse_position())
	
