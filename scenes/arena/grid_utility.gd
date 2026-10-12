extends FoldableContainer
class_name GridUtility

@export var blockManager: BlockManager
@export var blockAreaSize: Vector2

@onready var generate_grid_button: Button = $VBoxContainer/GenerateGridButton
@onready var blockAmountXField: LineEdit = $VBoxContainer/BlockX/BlockAmountX
@onready var blockAmountYField: LineEdit = $VBoxContainer/BlockY/BlockAmountY
@onready var blockPaddingXField: LineEdit = $VBoxContainer/BlockPaddingX/BlockPaddingX
@onready var blockPaddingYField: LineEdit = $VBoxContainer/BlockPaddingY/BlockPaddingY
@onready var areaVisibilityToggle: CheckButton = $VBoxContainer/ShowGrid/CheckButton

var blockAmountX: int = 10
var blockAmountY: int = 10
var blockPaddingX: int = 0
var blockPaddingY: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_grid_button.pressed.connect(_on_generate_grid_button_pressed)
	blockAmountXField.text_changed.connect(_on_block_amount_x_field_text_changed)
	blockAmountYField.text_changed.connect(_on_block_amount_y_field_text_changed)
	blockPaddingXField.text_changed.connect(_on_block_padding_x_field_text_changed)
	blockPaddingYField.text_changed.connect(_on_block_padding_y_field_text_changed)
	areaVisibilityToggle.pressed.connect(_on_area_visibility_toggle_pressed)
	
func _on_generate_grid_button_pressed() -> void:
	blockManager.clear_grid()
	#blockManager.generate_grid(blockAreaSize, LevelManager.generate_level(Vector2(blockAmountX, blockAmountY)), blockManager.block_padding, blockManager.grid_padding)
	blockManager.generate_grid(blockAreaSize, LevelManager.generate_level(Vector2(blockAmountX, blockAmountY)), Vector2(blockPaddingX, blockPaddingY), blockManager.grid_padding)

func _on_block_amount_x_field_text_changed(new_text: String) -> void:
	blockAmountX = int(new_text)
	
func _on_block_amount_y_field_text_changed(new_text: String) -> void:
	blockAmountY = int(new_text)
	
func _on_block_padding_x_field_text_changed(new_text: String) -> void:
	blockPaddingX = int(new_text)
	
func _on_block_padding_y_field_text_changed(new_text: String) -> void:
	blockPaddingY = int(new_text)
	
func _on_area_visibility_toggle_pressed() -> void:
	blockManager.toggle_grid_area_visibilty()
