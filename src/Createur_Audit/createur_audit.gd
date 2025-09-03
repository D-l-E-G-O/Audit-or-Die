extends Node2D
class_name CreateurAudit


func creer_audit(valeur_audit: int, proba_corruption: float, position_initiale: Vector2) -> void:
	"""
	Procédure qui crée un Audit.
	"""
	var audit: Audit = Audit.new(valeur_audit, position_initiale)
	audit.try_corrompre(proba_corruption)
	get_tree().current_scene.add_child(audit)
