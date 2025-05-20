extends Node3D

var is_in_detective_mode = false

signal exit_clicked

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ExitButton.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_exit_button_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		exit_clicked.emit()
