extends Range
class_name ProgressionBar


@export var initial_value: float = 0.0
@export var decrease_bar: TextureProgressBar

signal maximum_reached(cycles: int)

const TWEEN_DURATION: float = 0.5

var _tween: Tween


func _ready() -> void:
	set_value_no_signal(initial_value)
	allow_greater = true
	if decrease_bar:
		decrease_bar.step = self.step
	reset(true)


func add_value(val: float) -> void:
	var total: float = value + val
	if total >= max_value:
		maximum_reached.emit(total / max_value)
		value = floori(total) % floori(max_value)
	else:
		value = total


func apply_ratio(_ratio: float) -> void:
	add_value((value * _ratio) - value)


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


func _reset_bar(bar: Range, no_signal: bool) -> void:
	if !bar:
		return
	if no_signal:
		bar.set_value_no_signal(initial_value)
	else:
		bar.value = initial_value


func _get_tween() -> Tween:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	return _tween


func _on_value_changed(_value: float) -> void:
	update_decrease_bar()
