extends Node
class_name AuditorManager


const AUDITOR_SCENE: PackedScene = preload("res://src/Auditor/auditor.tscn")


func _ready() -> void:
	SignalBus.deploy_auditor.connect(_on_deploy_auditor)


func _on_deploy_auditor(zone: Zone) -> void:
	var auditor: Auditor = AUDITOR_SCENE.instantiate()
	auditor.assign_zone(zone)
	_spawn_auditor(auditor)


func _spawn_auditor(auditor: Auditor) -> void:
	add_child(auditor)
