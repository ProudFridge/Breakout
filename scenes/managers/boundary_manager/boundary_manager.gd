extends Node
class_name BoundaryManager

@onready var left_wall: StaticBody2D = $LeftWall
@onready var right_wall: StaticBody2D = $RightWall
@onready var bottom_wall: StaticBody2D = $BottomWall
@onready var top_wall: StaticBody2D = $TopWall

@export var gameAreaSize: Vector2 = Vector2(900, 900)
@onready var blockAreaSize: Vector2 = Vector2(gameAreaSize.x, 400)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("GameAreaSize: ", gameAreaSize)
	print("BlockAreaSize: ", blockAreaSize)
	
	# Set up the world boundaries and add the screen edges
	# Should change later for custom level sizes
	left_wall.position = Vector2(0,0)
	right_wall.position = Vector2(gameAreaSize.x, 0)
	bottom_wall.position = Vector2(0, gameAreaSize.y)
	top_wall.position = Vector2(0,0)
	
	left_wall.rotate(PI / 2)
	right_wall.rotate(-PI / 2)
	top_wall.rotate(PI)
