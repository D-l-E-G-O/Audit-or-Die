extends CharacterBody2D
class_name Auditeur


enum Niveau {Junior, Senior, Manager, Directeur}

const NIVEAU_CONFIG: Dictionary[Niveau, Dictionary] = {
	Niveau.Junior: {
		"nombre_range": Vector2i(1, 3),
		"valeur": 1,
		"proba_corruption": 0.15,
	},
	Niveau.Senior: {
		"nombre_range": Vector2i(3, 5),
		"valeur": 3,
		"proba_corruption": 0.10,
	},
	Niveau.Manager: {
		"nombre_range": Vector2i(5, 7),
		"valeur": 5,
		"proba_corruption": 0.05,
	},
	Niveau.Directeur: {
		"nombre_range": Vector2i(7, 9),
		"valeur": 7,
		"proba_corruption": 0.01,
	},
}

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
	SignalBus.creer_audit.emit(valeur_audit, proba_corruption, global_position)
	nb_audits += 1


func creer_plusieurs_audits() -> void:
	"""
	Procédure qui génère un certain nombre d'audits en fonction du niceau de l'auditeur
	"""
	var nb_audits_a_creer: int = get_nombre_audits(niveau)
	for i:int in range(nb_audits_a_creer):
		creer_audit()


static func get_nombre_audits(niveau_auditeur: Niveau) -> int:
	"""
	Fonction qui renvoie un entier correspondant au nombre d'audits à créer 
	en fonction du niveau de l'auditeur.
	"""
	var nombre_range: Vector2i = NIVEAU_CONFIG[niveau_auditeur]["nombre_range"]
	return randi_range(nombre_range.x, nombre_range.y)


static func get_valeur_audit(niveau_auditeur: Niveau) -> int:
	"""
	Fonction qui renvoie un entier correspondant à la valeur de l'audit 
	en fonction du niveau de l'auditeur.
	"""
	return NIVEAU_CONFIG[niveau_auditeur]["valeur"]


static func get_proba_corruption_audit(niveau_auditeur: Niveau) -> float:
	"""
	Fonction qui renvoie un flottant correspondant à la chance qu'un audit soit corrompu 
	en fonction du niveau de l'auditeur.
	"""
	return NIVEAU_CONFIG[niveau_auditeur]["proba_corruption"]
