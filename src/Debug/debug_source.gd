extends Node
class_name DebugSource


signal debug_values_changed


var get_debug_values_callable: Callable


func get_debug_values() -> Array[DebugValue]:
	return get_debug_values_callable.call()


func notify_debug_update() -> void:
	debug_values_changed.emit()
