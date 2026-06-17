extends Node
class_name LevelManager

static var grid: Array = []

# Loads levels from the levels.json file
# Currently can only store one level in the grid array
static func load_levels() -> void:
	# Reads the levels.json file and parses it
	var levelFile: FileAccess = FileAccess.open("res://levels.json", FileAccess.READ)
	var fileContent: String = levelFile.get_as_text()
	
	var json: JSON = JSON.new()
	var error: Error = json.parse(fileContent)	
	
	if error == OK:
		var data_received: Dictionary = json.data
		var blockGridTemp: Array = data_received["1"]["blockGrid"]
		
		var gridHeight: int = blockGridTemp.size()
		var gridWidth: int = blockGridTemp[0].size()
		
		for i: int in gridWidth:
			grid.append([])
			for j: int in gridHeight:
				grid[i].append(0) # Set a starter value for each position
		
		# Iterates through the grid
		# TODO: make it possible to list multiple levels
		for i: int in gridHeight:
			var column: Array = blockGridTemp.get(i)
			for j: int in gridWidth:
				grid[j][i] = int(column.get(j))
	else:
		print("JSON Parse Error: ", json.get_error_message(), " at line ", json.get_error_line())
		return
		
# Generates a full grid of blocks
static func generate_level(gridSize: Vector2) -> Array:
	var blockGrid: Array = []
	
	for i: int in gridSize.x:
			blockGrid.append([])
			for j: int in gridSize.y:
				blockGrid[i].append(1)
	
	return blockGrid
