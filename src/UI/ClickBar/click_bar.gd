@tool
extends Button
class_name ClickBar


signal cycle_completed(id: int, cycles: int)

@export var color: Color = Color(0.6, 0.6, 0.6)
@export var required_clicks: int = 3

@onready var progress_bar: ProgressionBar = $ProgressBar


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		update_color()


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	set_process(false)
	update_color()


func update_color() -> void:
	if progress_bar:
		var style_box = StyleBoxFlat.new()
		style_box.set_corner_radius_all(5)
		style_box.bg_color = color
		progress_bar.add_theme_stylebox_override("fill", style_box)


func add_value(nb_clicks: float) -> void:
	if nb_clicks > 0:
		progress_bar.add_value(progress_bar.max_value * (nb_clicks / required_clicks) + 0.01)


func set_value(value: float) -> void:
	progress_bar.value = value


func get_value() -> float:
	return progress_bar.value


func _on_pressed() -> void:
	add_value(Global.get_clicks())


func _on_progress_bar_maximum_reached(cycles: int) -> void:
	cycle_completed.emit(get_instance_id(), cycles)


func reset(no_signal: bool) -> void:
	progress_bar.reset(no_signal)
