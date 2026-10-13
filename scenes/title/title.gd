extends Control
class_name Title

var letterMargin: float = 10
var cellMargin: Vector2 = Vector2(4, 4)
var cellSize: Vector2 = Vector2(18,13)
var letterSize: Vector2 = Vector2(3 * cellSize.x + 2 * cellMargin.x, 5 * cellSize.y + 4 * cellMargin.y)

const B: Array[Array] = [
	[1, 1, 0],
	[1, 0, 1],
	[1, 1, 0],
	[1, 0, 1],
	[1, 1, 0]
]

const R: Array[Array] = [
	[1, 1, 0],
	[1, 0, 1],
	[1, 1, 0],
	[1, 0, 1],
	[1, 0, 1]
]

const E: Array[Array] = [
	[1, 1, 1],
	[1, 0, 0],
	[1, 1, 1],
	[1, 0, 0],
	[1, 1, 1]
]

const A: Array[Array] = [
	[0, 1, 0],
	[1, 0, 1],
	[1, 1, 1],
	[1, 0, 1],
	[1, 0, 1]
]

const K: Array[Array] = [
	[1, 0, 1],
	[1, 0, 1],
	[1, 1, 0],
	[1, 0, 1],
	[1, 0, 1]
]

const O: Array[Array] = [
	[0, 1, 0],
	[1, 0, 1],
	[1, 0, 1],
	[1, 0, 1],
	[0, 1, 0]
]

const U: Array[Array] = [
	[1, 0, 1],
	[1, 0, 1],
	[1, 0, 1],
	[1, 0, 1],
	[0, 1, 0]
]

const T: Array[Array] = [
	[1, 1, 1],
	[0, 1, 0],
	[0, 1, 0],
	[0, 1, 0],
	[0, 1, 0]
]

const letters: Array = [B,R,E,A,K,O,U,T]
const colors: Array[Color] = [Color("d2a44a"), Color("74cbea"), Color("48a048"), Color("d2d240"), Color("c84848")]

func _ready() -> void:
	for i: int in range(0, letters.size()):
		var letter: Array[Array] = letters[i]
		for row: int in range(0, letter.size()):
			for col: int in range(0, letter[row].size()):
				if letter[row][col] == 1:
					_create_color_rect(Vector2(col * (cellSize.x + cellMargin.x) + i * (letterSize.x + letterMargin), row * (cellSize.y + cellMargin.y)), colors[row])
	

func _create_color_rect(pos: Vector2, color: Color) -> void:
	var colorRect: ColorRect = ColorRect.new()
	colorRect.size = cellSize
	colorRect.color = color
	colorRect.position = pos
	add_child(colorRect)
