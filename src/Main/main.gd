extends Node2D


@export var auditor_manager: AuditorManager
@export var audit_manager: AuditManager
@export var zone_manager: ZoneManager

func spawn_auditor(auditor: Auditor) -> void:
	auditor_manager.add_child(auditor)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("create_audits"):
		for auditor: Auditor in auditor_manager.get_children():
			SignalBus.trigger_audit_creation.emit(auditor)
	elif Input.is_action_just_pressed("create_auditors"):
		for zone: Zone in zone_manager.get_children():
			SignalBus.deploy_auditor.emit(zone)
	elif Input.is_action_just_pressed("LMB"):
		SignalBus.left_mouse_button_pressed.emit()
