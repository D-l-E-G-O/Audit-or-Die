extends Node


@warning_ignore_start("unused_signal")


signal left_mouse_button_pressed

signal overlay_clicked(overlay_id: int)

signal finish_audit(audits: int)

signal update_upgrade_points(points: int)

@warning_ignore_restore("unused_signal")
