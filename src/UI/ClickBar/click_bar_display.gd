@tool
extends VBoxContainer
class_name ClickBarDisplay


@export var color: Color = Color(0.6, 0.6, 0.6)
@export var required_clicks: int = 3
@export var label: String = "Click"
@export var hide_cycles: bool = false

@onready var click_bar: ClickBar = $ClickBar
@onready var cps_label: ValueLabel = $CPSContainer/CPS
@onready var distribution_bar: ProgressBar = $CPSContainer/DistributionBar
@onready var required_clicks_label: ValueLabel = $CyclesContainer/RequiredClicks
@onready var cycles_label: ValueLabel = $CyclesContainer/Cycles


var cycles: int = 0:
	set(val):
		cycles = val
		cycles_label.value = cycles

var cps: float = 0.0:
	set(val):
		cps = val
		cps_label.value = cps


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		update_display()


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	set_process(false)
	update_display()


func update_display() -> void:
	click_bar.color = color
	var style_box: StyleBoxFlat = StyleBoxFlat.new()
	style_box.bg_color = color
	style_box.set_corner_radius_all(10)
	distribution_bar.add_theme_stylebox_override("fill", style_box)
	distribution_bar.add_theme_constant_override("outline_size", 7)
	click_bar.update_color()
	click_bar.text = label
	click_bar.required_clicks = required_clicks
	required_clicks_label.value = required_clicks
	cycles_label.visible = !hide_cycles
