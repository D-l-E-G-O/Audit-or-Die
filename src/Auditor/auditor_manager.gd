extends Node
class_name AuditorManager


const AUDITOR_SCENE: PackedScene = preload("res://src/Auditor/auditor.tscn")


func _ready() -> void:
	SignalBus.deploy_auditor.connect(_on_deploy_auditor)
	SignalBus.trigger_audit_creation.connect(_on_trigger_audit_creation)


func _on_deploy_auditor(zone: Zone) -> void:
	var auditor: Auditor = AUDITOR_SCENE.instantiate()
	auditor.assign_zone(zone)
	_spawn_auditor(auditor)
	SignalBus.add_pathfinding.emit(auditor, zone)


func _on_trigger_audit_creation(auditor: Auditor) -> void:
	auditor.create_multiple_audits()


func _spawn_auditor(auditor: Auditor) -> void:
	add_child(auditor)
