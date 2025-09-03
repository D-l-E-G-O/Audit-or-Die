extends Node


static var audit_scene: PackedScene = preload("res://src/Audits/audit.tscn")
static var audit_pool: Pool = Pool.new(audit_scene)


func creer_audit(valeur_audit: int, proba_corruption: float, position_initiale: Vector2) -> void:
	"""
	Procédure qui crée un audit.
	"""
	var audit: Audit = audit_pool.get_instance() as Audit
	print(audit)
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


func liberer_audit(audit: Audit) -> void:
	"""
	Procédure qui libère l'audit en le désactivant plutôt quand le détruisant complètement.
	"""
	audit_pool.liberer(audit)


func spawn_audit(audit: Audit) -> void:
	"""
	Procédure qui ajoute l'audit dans la scene s'il n'y existe pas déjà
	"""
	if get_children().find(audit) == -1: #Non existant
		add_child(audit)
