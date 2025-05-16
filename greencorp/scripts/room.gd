extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Interior/Room/CorkBoard.exit_clicked.connect(_on_corkboard_exit_clicked)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
		var space_state = get_world_3d().direct_space_state
	

func _on_corkboard_exit_clicked():
	$Player/TwistPivot/PitchPivot/Camera3D.current = true
