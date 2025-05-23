extends Control
@onready var button: Button = $ResumeButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_resume_button_pressed() -> void:
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
