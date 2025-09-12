extends Node


@warning_ignore_start("unused_signal")


signal create_audit(audit_value: int, corruption_proba: float, position: Vector2)

signal free_audit(audit: Audit)

signal collect_audit(audit: Audit)

signal add_confidence_bar_value(value: int)

signal start_stage_trial(stage: int)

signal end_trial(trial_succeeded: bool)


@warning_ignore_restore("unused_signal")
