extends Node
class_name AuditManager


const AUDIT_SCENE: PackedScene = preload("res://src/Audits/audit.tscn")


func _ready() -> void:
	SignalBus.create_audit.connect(_on_create_audit)
	SignalBus.free_audit.connect(_on_free_audit)
	SignalBus.collect_audit.connect(_on_collect_audit)


##Procédure qui se déclenche quand le joueur ou un auditeur crée un audit.
func _on_create_audit(audit_value: int, corruption_proba: float, initial_position: Vector2) -> void:
	var audit: Audit = AUDIT_SCENE.instantiate()
	init_audit(audit, audit_value, initial_position)
	try_corrompre_audit(audit, corruption_proba)
	spawn_audit(audit)


##Constructeur de l'audit.
func init_audit(audit: Audit, audit_value: int, initial_position: Vector2) -> void:
	audit.value = audit_value
	audit.global_position = initial_position


##Procédure qui a une chance de corrompre l'audit.
func try_corrompre_audit(audit: Audit, corruption_proba: float) -> void:
	var random: float = randf()
	if random <= corruption_proba:
		audit.corrupted = true
		audit.value *= -1
		audit.modulate = Color.RED


##Procédure qui se déclenche quand un audit est cliqué.
func _on_collect_audit(audit: Audit) -> void:
	SignalBus.add_confidence_bar_value.emit(audit.value)
	SignalBus.free_audit.emit(audit)


##Procédure qui se déclenche quand l'audit est cliqué ou quand il a disparu.
func _on_free_audit(audit: Audit) -> void:
	audit.queue_free()


func spawn_audit(audit: Audit) -> void:
	add_child(audit)
