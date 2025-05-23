extends Control
@onready var texture_rect: TextureRect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x = get_viewport().size.x / 2
	var y = get_viewport().size.y / 2
	texture_rect.position = Vector2(x,y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
