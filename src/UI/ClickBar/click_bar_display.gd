@tool
extends VBoxContainer
class_name ClickBarDisplay


@export var color: Color = Color(0.6, 0.6, 0.6)
@export var required_clicks: int = 3
@export var label: String = "Click"
@export var hide_cycles: bool = false
@export var hide_cps: bool = true

@export var cps_container: VBoxContainer
@export var click_bar: ClickBar
@export var cps_label: ValueLabel
@export var distribution_bar: ProgressBar
@export var cycles_label: ValueLabel


var cycles: int = 0:
	set(val):
		cycles = val
		if cycles_label:
			cycles_label.value = cycles

var cps: float = 0.0:
	set(val):
		cps = val
		if cps_label:
			cps_label.value = cps


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		update_display()


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	set_process(false)
	if !(cps_container && click_bar && cps_label && distribution_bar && cycles_label):
		push_error("%s : some @export variables are null" % name)
	SignalBus.set_cps_info_visibility.connect(_on_set_cps_info_visibility)
	update_display()


func update_display() -> void:
	update_click_bar()
	update_distribution_bar()
	update_cycles_label()
	update_cps_visibility()


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


func update_cycles_label() -> void:
	if cycles_label:
		cycles_label.set_visibility(!hide_cycles)


func update_cps_visibility() -> void:
	if cps_container:
		cps_container.visible = !hide_cps


func _on_set_cps_info_visibility(show_cps: bool) -> void:
	hide_cps = !show_cps
	if cps_container:
		cps_container.visible = show_cps
