extends CharacterBody2D
class_name Audit


var valeur: int = 0
var corrompu: bool = false


func _init(valeur_audit: int, position_initiale: Vector2) -> void:
	valeur = valeur_audit
	global_position = position_initiale


func try_corrompre(proba_corruption: float) -> void:
	var random: float = randf()
	if random <= proba_corruption:
		corrompu = true
