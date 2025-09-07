extends Node
class_name AuditManager


const AUDIT_SCENE: PackedScene = preload("res://src/Audits/audit.tscn")


func _ready() -> void:
	SignalBus.creer_audit.connect(_on_creer_audit)
	SignalBus.liberer_audit.connect(_on_liberer_audit)
	SignalBus.recuperer_audit.connect(_on_recuperer_audit)


func _on_creer_audit(valeur_audit: int, proba_corruption: float, position_initiale: Vector2) -> void:
	"""
	Procédure qui se déclenche quand le joueur ou un auditeur crée un audit.
	"""
	var audit: Audit = AUDIT_SCENE.instantiate()
	init_audit(audit, valeur_audit, position_initiale)
	try_corrompre_audit(audit, proba_corruption)
	spawn_audit(audit)


func init_audit(audit: Audit, valeur_audit: int, position_initiale: Vector2) -> void:
	"""
	Constructeur de l'audit.
	"""
	audit.valeur = valeur_audit
	audit.global_position = position_initiale


func try_corrompre_audit(audit: Audit, proba_corruption: float) -> void:
	"""
	Procédure qui a une chance rendre l'audit corrompu.
	"""
	var random: float = randf()
	if random <= proba_corruption:
		audit.corrompu = true
		audit.valeur *= -1
		audit.modulate = Color.RED


func _on_recuperer_audit(audit: Audit) -> void:
	"""
	Procédure qui se déclenche quand un audit est cliqué.
	"""
	var valeur_audit: int = audit.get_valeur()
	SignalBus.ajouter_valeur_barre_confiance.emit(valeur_audit)
	SignalBus.liberer_audit.emit(audit)


func _on_liberer_audit(audit: Audit) -> void:
	"""
	Procédure qui se déclenche quand l'audit est cliqué ou quand il a disparu.
	"""
	audit.queue_free()


func spawn_audit(audit: Audit) -> void:
	"""
	Procédure qui ajoute l'audit dans la scene.
	"""
	add_child(audit)


#region Pooling system

#static var audit_pool: Pool = Pool.new(AUDIT_SCENE)

#func creer_audit(valeur_audit: int, proba_corruption: float, position_initiale: Vector2) -> void:
	#"""
	#Procédure qui crée un audit.
	#"""
	#var audit: Audit = audit_pool.get_instance() as Audit
	#init_audit(audit, valeur_audit, position_initiale)
	#try_corrompre_audit(audit, proba_corruption)
	#spawn_audit(audit)

#func liberer_audit(audit: Audit) -> void:
	#"""
	#Procédure qui libère l'audit en le désactivant plutôt quand le détruisant complètement.
	#"""
	#audit_pool.liberer(audit)


#func spawn_audit(audit: Audit) -> void:
	#"""
	#Procédure qui ajoute l'audit dans la scene s'il n'y existe pas déjà
	#"""
	#if get_children().find(audit) == -1: #Non existant
		#add_child(audit)
#endregion
