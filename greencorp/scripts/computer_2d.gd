extends Node2D
@onready var pause_menu = $PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		print_debug("Cancel pressed")
		_on_cancel_pressed()
	elif event.is_action_pressed("escape"):
		pause_menu.show()
	
func _on_cancel_pressed():
	go_up_the_tree()

func go_up_the_tree():
	print_debug("Going up the tree")
