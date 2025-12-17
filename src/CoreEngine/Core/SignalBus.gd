extends Node


@warning_ignore_start("unused_signal")

signal finish_audit(audits: int)

signal level_up(level: int)

signal update_upgrade_points(points: int)

signal update_auto_clicks(value: float)

signal set_cps_info_visibility(show: bool)

signal synchronize_click_bars

signal show_main_menu

@warning_ignore_restore("unused_signal")
