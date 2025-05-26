extends Control
@onready var button: Button = $ResumeButton

var is_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_resume_button_pressed() -> void:
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_active(false)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func set_active(new_status):
	is_active = new_status
	
func get_is_active():
	return is_active
