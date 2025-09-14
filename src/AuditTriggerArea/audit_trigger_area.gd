extends Area2D
class_name AuditTriggerArea


@export var collision_shape: CollisionShape2D


func _ready() -> void:
	if !collision_shape:
		push_error("The collect zone has no collision shape.")
		return
	monitorable = false
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is Auditor:
		SignalBus.trigger_audit_creation.emit(area as Auditor)
