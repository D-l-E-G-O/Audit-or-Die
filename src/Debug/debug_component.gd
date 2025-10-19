extends Node
class_name DebugComponent


signal debug_values_changed

var get_debug_values_callable: Callable


func get_debug_values() -> Array[DebugValue]:
	if get_debug_values_callable:
		return get_debug_values_callable.call()
	return []


func notify_debug_update() -> void:
	debug_values_changed.emit()


func attach_debug_panel(parent: Node, offset_y: float = 0.0) -> void:
	var panel: DebugPanel = DebugPanel.new()
	panel.debug_source = self
	parent.add_child(panel)
	panel.position.y += offset_y
