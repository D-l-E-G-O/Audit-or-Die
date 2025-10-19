extends Node

signal toggle_debug(state: bool)

var debug_visible: bool = false


func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_debug"):  # bind 'd' in Input Map
		debug_visible = !debug_visible
		toggle_debug.emit(debug_visible)
