extends CharacterBody2D
class_name Auditeur


enum Niveau {Junior, Senior, Manager, Directeur}

var nom: String = get_nom_aleatoire()
var niveau: Niveau = Niveau.Junior
var nb_audits: int = 0


static func get_nom_aleatoire() -> String:
	"""
	Fonction qui donne un nom aléatoire aux auditeurs.
	"""
	return ""


func creer_audit() -> void:
	"""
	Procédure qui génère un audit selon les paramètres de l'auditeur.
	"""
	var valeur_audit: int = get_valeur_audit(niveau)
	var proba_corruption: float = get_proba_corruption_audit(niveau)
	AuditManager.creer_audit(valeur_audit, proba_corruption, global_position)
	nb_audits += 1


static func get_valeur_audit(niveau_auditeur: Niveau) -> int:
	"""
	Fonction qui renvoie un entier correspondant à la valeur de l'audit 
	par rapport au niveau de l'auditeur.
	"""
	match niveau_auditeur:
		Niveau.Junior:
			return 1
		Niveau.Senior:
			return 3
		Niveau.Manager:
			return 5
		Niveau.Directeur:
			return 7
	return 0


static func get_proba_corruption_audit(niveau_auditeur: Niveau) -> float:
	"""
	Fonction qui renvoie un flottant correspondant à la chance qu'un audit soit corrompu 
	par rapport au niveau de l'auditeur.
	"""
	match niveau_auditeur:
		Niveau.Junior:
			return 0.15
		Niveau.Senior:
			return 0.10
		Niveau.Manager:
			return 0.05
		Niveau.Directeur:
			return 0.01
	return 0.0
