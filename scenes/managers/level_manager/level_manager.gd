extends Node
class_name LevelManager
## Handles level loading from the levels.json file

static var grid: Array[Array] = []

# Loads levels from the levels.json file
# Can only store one level in the grid array
static func load_levels() -> void:
	# Clear the grid array in case this function is called more than once
	grid.clear()
	
	# Reads the levels.json file and stores its content
	var levelFile: FileAccess = FileAccess.open("res://levels.json", FileAccess.READ)
	var fileContent: String = levelFile.get_as_text()
	
	var json: JSON = JSON.new()
	var error: Error = json.parse(fileContent)	
	
	if error == OK:
		var data_received: Array = json.data
		var levelAmount: int = data_received.size()
		
		for level: int in levelAmount:
			# Add and array to store all the grids for the specified levels
			grid.append([])
			var currentLevel: Array = data_received[level]
			
			for levelIdx: int in currentLevel.size():	
				grid[level].append([])
				var blockGridTemp: Array = currentLevel[levelIdx]["blockGrid"]
				
				var gridHeight: int = blockGridTemp.size()
				var gridWidth: int = blockGridTemp[0].size()
				
				# Create 2d array to store the grid
				for i: int in gridWidth:
					grid[level][levelIdx].append([])
					for j: int in gridHeight:
						grid[level][levelIdx][i].append(0) # Set a starter value for each position
				
				# Iterates through the grid
				# TODO: make it possible to list multiple levels
				for i: int in gridHeight:
					var column: Array = blockGridTemp.get(i)
					for j: int in gridWidth:
						grid[level][levelIdx][j][i] = int(column.get(j))
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
