extends Control
#class_name PolygonButton

@export var width: float = 240;
var height: float = sqrt(width * width - (width / 2) * (width / 2))

@onready var collision_polygon_2d: CollisionPolygon2D = $Area2D/CollisionPolygon2D

var normalColor: Color = Color.AZURE
var hoverColor: Color = Color.AQUAMARINE

var points: PackedVector2Array = PackedVector2Array([
		Vector2(-width / 2, height / 2),
		Vector2(width / 2, height / 2),
		Vector2(0, -height / 2)
	])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	
	self_modulate = normalColor
	position = get_viewport_rect().size / 2
	size = Vector2(width,width)
	collision_polygon_2d.polygon = points

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw() -> void:
	draw_colored_polygon(points, Color.WHITE)

func _has_point(point: Vector2) -> bool:
	return Geometry2D.is_point_in_polygon(point, points)

func _on_mouse_entered() -> void:
	self_modulate = hoverColor
	
func _on_mouse_exited() -> void:
	self_modulate = normalColor
	
