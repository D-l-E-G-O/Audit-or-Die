extends Resource
class_name Upgrade


@export var level: int = 0
@export var label: String
@export var description: String
@export var base_cost: int = 10
@export var cost_multiplier: float = 1.4
@export var initial_effect: float = 1.0
@export var base_effect: float = 1.0
@export var effect_multiplier: float = 1.5


## Fonction renvoyant le coût d'amélioration.
## @return int Le coût d'amélioration.
func get_cost() -> int:
	return floori(base_cost * pow(cost_multiplier, level))


## Fonction renvoyant l'effet (valeur) de l'amélioration.
## @return float l'effet de l'amélioration.
func get_effect() -> float:
	var effect: float = initial_effect
	# Appliquer le multiplicateur
	if level > 0:
		effect = base_effect * pow(effect_multiplier, level)
	return snappedf(effect, 0.1)


## Fonction renvoyant vrai si les points suffisent pour améliorer, sinon faux.
## @params points Le nombre de points.
## @return bool Vrai si le nombre de points est supérieur ou égal au coût, faux sinon.
func can_upgrade(points: int) -> bool:
	return points >= get_cost()


## Procédure d'amélioration.
func upgrade() -> void:
	# Mise à jour du nombre de points d'amélioration
	Global.set_upgrade_points(Global.get_upgrade_points() - get_cost())
	SignalBus.upgrade.emit()
	level += 1
