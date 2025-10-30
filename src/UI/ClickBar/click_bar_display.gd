@tool
extends VBoxContainer
class_name ClickBarDisplay


@export var color: Color = Color(0.6, 0.6, 0.6)
@export var required_clicks: int = 3
@export var label: String = "Click"
@export var hide_cycles: bool = false
@export var hide_required_clicks: bool = false

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
	SignalBus.set_required_clicks_visibility.connect(_on_set_required_clicks_visibility)
	update_display()


func update_display() -> void:
	update_click_bar()
	update_distribution_bar()
	update_required_clicks_label()
	update_cycles_label()


func update_click_bar() -> void:
	if click_bar:
		click_bar.color = color
		click_bar.update_color()
		click_bar.text = label
		click_bar.required_clicks = required_clicks


func update_distribution_bar() -> void:
	if distribution_bar:
		var style_box: StyleBoxFlat = StyleBoxFlat.new()
		style_box.bg_color = color
		style_box.set_corner_radius_all(5)
		distribution_bar.add_theme_stylebox_override("fill", style_box)
		distribution_bar.add_theme_constant_override("outline_size", 7)


func update_required_clicks_label() -> void:
	if required_clicks_label:
		required_clicks_label.value = required_clicks
		required_clicks_label.visible = !hide_required_clicks


func update_cycles_label() -> void:
	if cycles_label:
		cycles_label.visible = !hide_cycles


func _on_set_required_clicks_visibility(hide_label: bool) -> void:
	hide_required_clicks = hide_label
	required_clicks_label.visible = !hide_label
