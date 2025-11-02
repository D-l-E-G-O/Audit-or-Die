extends Node


@warning_ignore_start("unused_signal")


#signal left_mouse_button_pressed

#signal overlay_clicked(overlay_id: int)

signal finish_audit(audits: int)

signal update_upgrade_points(points: int)

signal update_auto_clicks(value: float)

signal set_required_clicks_visibility(show: bool)

signal set_cps_info_visibility(show: bool)

signal synchronize_click_bars

signal show_main_menu

@warning_ignore_restore("unused_signal")
