extends Button

var meshNum: int = 45
var meshHeight: float = 8
var meshGap: float = 5
# percentage of space that should be accorded to the buttons
var buttonFreeSpaceRatio: float = 0.8
var meshes: Array[MeshInstance2D] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var totalButtonSpace: float = size.x * buttonFreeSpaceRatio
	var gapSize: float = (size.x - totalButtonSpace) / (meshNum - 1)
	var meshSize: Vector2 = Vector2(totalButtonSpace / meshNum, meshHeight)
	
	for i: int in meshNum:
		var mesh: MeshInstance2D = MeshInstance2D.new()
		mesh.mesh = QuadMesh.new()
		mesh.mesh.size = meshSize
		mesh.position.y = size.y + meshSize.y
		#mesh.position.x = 100
		mesh.position.x = meshSize.x / 2 + gapSize * i + meshSize.x * (i)
		meshes.append(mesh)
		add_child(mesh)

var t: float = 0
var phaseDiff: float = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var i: int = 0
	for mesh: MeshInstance2D in meshes:
		mesh.modulate = Color(1 * sin(t + i * phaseDiff),1,1)
		i += 1
	t += delta
