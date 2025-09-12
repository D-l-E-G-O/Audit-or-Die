extends CharacterBody2D
class_name Auditor


enum Level {Junior, Senior, Manager, Director}

const LEVEL_CONFIG: Dictionary[Level, Dictionary] = {
	Level.Junior: {
		"number_range": Vector2i(1, 3),
		"value": 100,
		"corruption_proba": 0.15,
	},
	Level.Senior: {
		"number_range": Vector2i(3, 5),
		"value": 3,
		"corruption_proba": 0.10,
	},
	Level.Manager: {
		"number_range": Vector2i(5, 7),
		"value": 5,
		"corruption_proba": 0.05,
	},
	Level.Director: {
		"number_range": Vector2i(7, 9),
		"value": 7,
		"corruption_proba": 0.01,
	},
}

var level: Level = Level.Junior
var nb_audits: int = 0


##Procédure qui entraine la création d'un audit selon les paramètres de l'auditeur.
func create_audit() -> void:
	var audit_value: int = get_value_audit(level)
	var corruption_proba: float = get_corruption_proba_audit(level)
	SignalBus.create_audit.emit(audit_value, corruption_proba, global_position)
	nb_audits += 1


##Procédure qui génère un certain number d'audits en fonction du level de l'auditeur.
func create_multiple_audits() -> void:
	var nb_audits_to_create: int = get_number_audits(level)
	for i:int in range(nb_audits_to_create):
		create_audit()


##Fonction qui renvoie un entier correspondant au number d'audits à créer 
##en fonction du level de l'auditeur.
static func get_number_audits(auditor_level: Level) -> int:
	var number_range: Vector2i = LEVEL_CONFIG[auditor_level]["number_range"]
	return randi_range(number_range.x, number_range.y)


##Fonction qui renvoie un entier correspondant à la value de l'audit 
##en fonction du level de l'auditeur.
static func get_value_audit(auditor_level: Level) -> int:
	return LEVEL_CONFIG[auditor_level]["value"]


##Fonction qui renvoie un flottant correspondant à la chance qu'un audit soit corrompu 
##en fonction du level de l'auditeur.
static func get_corruption_proba_audit(auditor_level: Level) -> float:
	return LEVEL_CONFIG[auditor_level]["corruption_proba"]
