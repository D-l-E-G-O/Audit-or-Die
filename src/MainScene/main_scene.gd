extends Node2D


@onready var sync_click_bars: Button = $UI/VBoxContainer/SyncClickBars


func _ready() -> void:
	sync_click_bars.hide()
	SignalBus.set_cps_info_visibility.connect(_on_set_cps_info_visibility)


func _on_show_infos_check_button_toggled(toggled_on: bool) -> void:
	SignalBus.set_required_clicks_visibility.emit(toggled_on)


func _on_back_to_menu_pressed() -> void:
	SignalBus.show_main_menu.emit()


func _on_sync_click_bars_pressed() -> void:
	SignalBus.synchronize_click_bars.emit()


func _on_set_cps_info_visibility(show_button: bool) -> void:
	sync_click_bars.visible = show_button
