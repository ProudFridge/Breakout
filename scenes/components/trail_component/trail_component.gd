extends Line2D
class_name TrailComponent

var characterBody: CharacterBody2D

@export var pointLimit: int = 10
#var distanceTraveled: float = 0
#var previousPosition: Vector2 = Vector2.ZERO
#var currentPosition: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	characterBody = get_parent()
	#previousPosition = currentPosition
	#currentPosition = position
	#position = characterBody.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#previousPosition = currentPosition
	#currentPosition = characterBody.position
	
	#var distance: Vector2 = currentPosition - previousPosition
	#distanceTraveled += distance.length()
	
	if get_point_count() > pointLimit:
		remove_point(0)
	else:
		add_point(characterBody.position)
		
		
#func line_length() -> float:
	#var length: float = 0
	#var previousPoint: Vector2
	#var currentPoint: Vector2 = points.get(0)
	#for point: Vector2 in points:
		#previousPoint = currentPoint
		#currentPoint = point
		#length += (currentPoint - previousPoint).length()
	#return length
	
func clear() -> void:
	clear_points()
