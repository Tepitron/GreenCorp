extends MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func draw():
	
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	
	mesh.surface_set_normal(Vector3(0, 0, 1))
	mesh.surface_set_uv(Vector2(0, 1))
	mesh.surface_add_vertex(Vector3(1,1,1))
	
	mesh.surface_add_vertex(Vector3(2,2,2))
	
	mesh.surface_end()
	
