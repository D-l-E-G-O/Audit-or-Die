extends Control
class_name DebugPanel


@export var debug_source: DebugComponent
var container: VBoxContainer


func _ready() -> void:
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	container = VBoxContainer.new()
	add_child(container)
	if !debug_source:
		debug_source = get_parent() as DebugComponent
	DebugManager.toggle_debug.connect(_on_toggle_debug_mode)
	if debug_source:
		debug_source.debug_values_changed.connect(_update_labels)
	_populate_labels()


func _populate_labels() -> void:
	if not debug_source:
		return
	for value in debug_source.get_debug_values():
		var label: Label = Label.new()
		label.name = value._name
		label.text = "%s: %s" % [value._name, str(value.get_value())]
		container.add_child(label)


func _update_labels() -> void:
	if not debug_source:
		return
	for value in debug_source.get_debug_values():
		var label: Label = container.get_node_or_null(value._name) as Label
		if label:
			label.text = "%s: %s" % [value._name, str(value.get_value())]


func _on_toggle_debug_mode(state: bool) -> void:
	visible = state
	if visible:
		_update_labels()
