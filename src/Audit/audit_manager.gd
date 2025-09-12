extends Node
class_name AuditManager


const AUDIT_SCENE: PackedScene = preload("res://src/Audit/audit.tscn")


func _ready() -> void:
	SignalBus.create_audit.connect(_on_create_audit)
	SignalBus.free_audit.connect(_on_free_audit)
	SignalBus.collect_audit.connect(_on_collect_audit)


func _on_create_audit(audit_value: int, corruption_proba: float, zone: Zone) -> void:
	var audit: Audit = AUDIT_SCENE.instantiate()
	audit.init_audit(audit_value, zone.global_position)
	audit.try_corrompre_audit(corruption_proba)
	_spawn_audit(audit)


func _on_collect_audit(audit: Audit) -> void:
	SignalBus.add_confidence_bar_value.emit(audit.value)
	SignalBus.free_audit.emit(audit)


func _on_free_audit(audit: Audit) -> void:
	audit.queue_free()


func _spawn_audit(audit: Audit) -> void:
	add_child(audit)
