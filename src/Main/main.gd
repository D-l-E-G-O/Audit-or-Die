extends Node2D


@export var auditor_manager: AuditorManager
@export var audit_manager: AuditManager
@export var confidence_bar: ConfidenceBar
@export var stage: Label
@export var zone_manager: ZoneManager


func _on_confidence_bar_value_changed(value: float) -> void:
	stage.text = "Stage %d (%d/%d)" % [confidence_bar.stage, confidence_bar.value, confidence_bar.max_value]


func spawn_auditor(auditor: Auditor) -> void:
	auditor_manager.add_child(auditor)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("create_audits"):
		for auditor: Auditor in auditor_manager.get_children():
			SignalBus.trigger_audit_creation.emit(auditor)
	elif Input.is_action_just_pressed("create_auditors"):
		for zone: Zone in zone_manager.get_children():
			SignalBus.deploy_auditor.emit(zone)
			
