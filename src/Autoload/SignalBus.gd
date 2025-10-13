extends Node


@warning_ignore_start("unused_signal")


signal deploy_auditor(zone: Zone)

signal add_pathfinding(auditor: Auditor, zone: Zone)

signal trigger_audit_creation(auditor: Auditor)

signal create_audit(audit_value: int, corruption_proba: float, zone: Zone)

signal collect_audit(audit: Audit)

signal free_audit(audit: Audit)

signal add_confidence_bar_value(value: int, zone: Zone)

signal reached_max_confidence

signal update_zone_stats(zone: Zone)

signal update_info_com_stats

signal update_it_stats

signal update_civil_stats

signal update_pharma_stats

signal update_physics_stats

signal left_mouse_button_pressed

signal overlay_clicked(overlay_id: int)


@warning_ignore_restore("unused_signal")
