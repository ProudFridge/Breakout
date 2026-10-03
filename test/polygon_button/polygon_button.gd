extends Button
class_name PolygonButton
## A button that can take the shape of a polygon
##
## Can take a packed array of points to display a polygon that's also a button

@export var width: float = 240;
var height: float = sqrt(width * width - (width / 2) * (width / 2))

## Points describing the button's shape
var points: PackedVector2Array = PackedVector2Array([
		Vector2(-width / 2, height / 2),
		Vector2(width / 2, height / 2),
		Vector2(0, -height / 2)
	])
	
## Colors
#region Colors used for the buttons
@export var normal: Color = Color.BLACK ## Normal color of the button
@export var hover: Color = Color.DIM_GRAY ## Hover color of the button
#endregion

func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	
	self_modulate = normal
	position = get_viewport_rect().size / 2
	size = Vector2(width,width)
	
func _draw() -> void:
	draw_colored_polygon(points, self_modulate)

func _process(delta: float) -> void:
	rotation += 0.1 * delta

func _has_point(point: Vector2) -> bool:
	return Geometry2D.is_point_in_polygon(point, points)
	
func _on_mouse_entered() -> void:
	self_modulate = hover
	
func _on_mouse_exited() -> void:
	self_modulate = normal
	
