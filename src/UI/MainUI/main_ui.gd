extends Control


@export var sync_click_bars: Button


func _ready() -> void:
	if !(sync_click_bars):
		push_error("%s : some @export variables are null" % name)
	if sync_click_bars:
		sync_click_bars.hide()
	SignalBus.set_cps_info_visibility.connect(_on_set_cps_info_visibility)


func _on_show_infos_check_button_toggled(toggled_on: bool) -> void:
	toggled_on = toggled_on
	pass


func _on_back_to_menu_pressed() -> void:
	SignalBus.show_main_menu.emit()


func _on_sync_click_bars_pressed() -> void:
	SignalBus.synchronize_click_bars.emit()


func _on_set_cps_info_visibility(show_button: bool) -> void:
	if sync_click_bars:
		sync_click_bars.visible = show_button
