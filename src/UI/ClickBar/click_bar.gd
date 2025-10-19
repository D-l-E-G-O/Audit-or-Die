extends Button
class_name ClickBar


signal cycle_completed(id: int, cycles: int)

@export var color: Color = Color(0.6, 0.6, 0.6)
@export var required_clicks: int = 3

@onready var progress_bar: ProgressionBar = $ProgressBar


func _ready() -> void:
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = color
	progress_bar.add_theme_stylebox_override("fill", stylebox)


func _on_pressed() -> void:
	progress_bar.add_value(progress_bar.max_value / required_clicks)


func _on_progress_bar_maximum_reached(cycles: int) -> void:
	progress_bar.reset(true)
	cycle_completed.emit(get_instance_id(), cycles)
