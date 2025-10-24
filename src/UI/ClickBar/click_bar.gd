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
	set_process(false)
	update_color()


func update_color() -> void:
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = color
	progress_bar.add_theme_stylebox_override("fill", stylebox)


func _on_pressed() -> void:
	progress_bar.add_value(progress_bar.max_value * (Global.get_clicks() / required_clicks) + 0.01)


func _on_progress_bar_maximum_reached(cycles: int) -> void:
	cycle_completed.emit(get_instance_id(), cycles)


func reset(no_signal: bool) -> void:
	progress_bar.reset(no_signal)
