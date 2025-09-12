extends Node


@warning_ignore_start("unused_signal")


signal deploy_auditor(zone: Zone)

signal create_audit(audit_value: int, corruption_proba: float, zone: Zone)

signal collect_audit(audit: Audit)

signal free_audit(audit: Audit)

signal add_confidence_bar_value(value: int)

signal reached_max_confidence


@warning_ignore_restore("unused_signal")
