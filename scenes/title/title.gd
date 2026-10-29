@tool
extends Control
class_name Title

@export var letterMargin: float = 10
@export var cellMargin: Vector2 = Vector2(4, 4)
@export var cellSize: Vector2 = Vector2(18,13)
var letterSize: Vector2 = Vector2(3 * cellSize.x + 2 * cellMargin.x, 5 * cellSize.y + 4 * cellMargin.y)
var titleSize: Vector2 = Vector2(8 * letterSize.x + 7 * letterMargin, letterSize.y)

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
#const colors: Array[Color] = [Color("d2a44a"), Color("74cbea"), Color("48a048"), Color("d2d240"), Color("c84848")]
const colors: Array[Color] = [Color("d2a44a"), Color("4dc1ebff"), Color("62d962ff"), Color("f2f227ff"), Color("e32d2dff")]

func _ready() -> void:
	for i: int in range(0, letters.size()):
		var letter: Array[Array] = letters[i]
		for row: int in range(0, letter.size()):
			for col: int in range(0, letter[row].size()):
				if letter[row][col] == 1:
					_create_color_rect(Vector2((col * (cellSize.x + cellMargin.x) + i * (letterSize.x + letterMargin)) - titleSize.x / 2, row * (cellSize.y + cellMargin.y)), colors[row])
	
#func _process(delta: float) -> void:
	#var children: Array[Node] = get_children()
	#for i: int in children.size():
		#var node: ColorRect = children.get(i)
		#node.offset_transform_position = Vector2(sin(float(Time.get_ticks_msec()) / 1000.0  + 2 * i), 0)


func _create_color_rect(pos: Vector2, color: Color) -> void:
	var colorRect: TitleColorRect = load("res://scenes/title/title_color_rect.tscn").instantiate()
	colorRect.size = cellSize
	colorRect.color = color
	colorRect.position = pos
	colorRect.offset_transform_enabled = true
	add_child(colorRect)
