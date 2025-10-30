extends Node2D




func _on_hide_infos_check_button_toggled(toggled_on: bool) -> void:
	SignalBus.set_required_clicks_visibility.emit(toggled_on)
