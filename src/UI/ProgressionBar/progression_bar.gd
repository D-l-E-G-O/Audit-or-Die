extends TextureProgressBar
class_name ProgressionBar


@export var decrease_bar: TextureProgressBar

signal maximum_reached

const TWEEN_DURATION: float = 0.5

var _tween: Tween


func _ready() -> void:
	reset(true)


func add_value(val: float) -> void:
	value += val
	if value == max_value:
		maximum_reached.emit()


func update_decrease_bar() -> void:
	if !decrease_bar:
		return
	if decrease_bar.value <= self.value:
		# Instant increase
		decrease_bar.value = self.value
	else:
		# Progressive decrease
		_get_tween().tween_property(decrease_bar, "value", self.value, TWEEN_DURATION)


func reset(no_signal: bool) -> void:
	_reset_bar(self, no_signal)
	_reset_bar(decrease_bar, no_signal)


static func _reset_bar(bar: TextureProgressBar, no_signal: bool) -> void:
	if !bar:
		return
	if no_signal:
		bar.set_value_no_signal(bar.min_value)
	else:
		bar.value = bar.min_value


func _get_tween() -> Tween:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	return _tween


func _on_value_changed(_value: float) -> void:
	update_decrease_bar()
