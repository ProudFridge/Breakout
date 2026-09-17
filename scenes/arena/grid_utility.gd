extends GridContainer
class_name GridUtility

@export var blockManager: BlockManager
@export var blockAreaSize: Vector2

@onready var generate_grid_button: Button = $FoldableContainer/VBoxContainer/GenerateGridButton
@onready var blockAmountXField: LineEdit = $FoldableContainer/VBoxContainer/BlockX/BlockAmountX
@onready var blockAmountYField: LineEdit = $FoldableContainer/VBoxContainer/BlockY/BlockAmountY
@onready var areaVisibilityToggle: CheckButton = $FoldableContainer/VBoxContainer/ShowGrid/CheckButton

var blockAmountX: int = 0
var blockAmountY: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_grid_button.pressed.connect(_on_generate_grid_button_pressed)
	blockAmountXField.text_changed.connect(_on_block_amount_x_field_text_changed)
	blockAmountYField.text_changed.connect(_on_block_amount_y_field_text_changed)
	areaVisibilityToggle.pressed.connect(_on_area_visibility_toggle_pressed)
	
func _on_generate_grid_button_pressed() -> void:
	blockManager.clear_grid()
	blockManager.generate_grid(blockAreaSize, LevelManager.generate_level(Vector2(blockAmountX, blockAmountY)), blockManager.block_padding, blockManager.grid_padding)

func _on_block_amount_x_field_text_changed(new_text: String) -> void:
	blockAmountX = int(new_text)
	
func _on_block_amount_y_field_text_changed(new_text: String) -> void:
	blockAmountY = int(new_text)
	
func _on_area_visibility_toggle_pressed() -> void:
	blockManager.toggle_grid_area_visibilty()
