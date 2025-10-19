extends Resource
class_name Upgrade


@export var label: String
@export var description: String
@export var base_cost: int = 10
@export var cost_multiplier: float = 1.4
@export var base_effect: float = 1.0
@export var effect_multiplier: float = 1.5

var level: int = 0


func get_cost() -> int:
	return floori(base_cost * pow(cost_multiplier, level))


func get_effect() -> float:
	return base_effect * pow(effect_multiplier, level)


func can_upgrade(points: int) -> bool:
	return points >= get_cost()


func upgrade() -> void:
	Global.set_upgrade_points(Global.get_upgrade_points() - get_cost())
	level += 1
