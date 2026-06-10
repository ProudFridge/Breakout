extends Node2D

@onready var left_wall: CollisionShape2D = $WorldBoundary/Walls/LeftWall
@onready var right_wall: CollisionShape2D = $WorldBoundary/Walls/RightWall
@onready var bottom_wall: CollisionShape2D = $WorldBoundary/Walls/BottomWall
@onready var top_wall: CollisionShape2D = $WorldBoundary/Walls/TopWall

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set up the world boundaries otbe add the screen edges
	# Should change later for custom level sizes
	var viewportSize: Vector2 = get_viewport().size
	left_wall.position = Vector2(0,0)
	right_wall.position = Vector2(viewportSize.x, 0)
	bottom_wall.position = Vector2(0, viewportSize.y)
	top_wall.position = Vector2(0,0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
