extends Node


signal upgrade_points_changed(points: int)
signal auto_clicks_changed(value: float)
signal level_changed(new_level: int)
signal finish_audit(audits: int)

var _upgrade_points: int = 0
var _clicks: float = 1.0
var _auto_clicks: float = 0.0
var _level: int = 0
var _audits: int = 0


## Fonction renvoyant le nombre de points d'amélioration.
## @return int Nombre de points d'amélioration.
func get_upgrade_points() -> int:
	return _upgrade_points

## Procédure de mise à jour des points d'amélioration.
## @params value Nouveau nombre de points d'amélioration.
func set_upgrade_points(value: int) -> void:
	_upgrade_points = value
	# Emettre le signal de mise à jour
	upgrade_points_changed.emit(_upgrade_points)


## Fonction renvoyant la valeur de chaque clic.
## @return float La valeur d'un clic.
func get_clicks() -> float:
	return _clicks

## Procédure de mise à jour de la valeur des clics.
## @params value Nouvelle valeur des clics.
func set_clicks(value: float) -> void:
	_clicks = value


## Fonction renvoyant la valeur des clics passifs des auditeurs.
## @return float La valeur des clics passifs.
func get_auto_clicks() -> float:
	return _auto_clicks

## Procédure de mise à jour de la valeur des clics passifs des auditeurs.
## @params value Nouvelle valeur des clics passifs.
func set_auto_clicks(value: float) -> void:
	_auto_clicks = value
	# Emettre le signal de mise à jour
	auto_clicks_changed.emit(_auto_clicks)


## Procédure de mise à jour du niveau.
func level_up() -> void:
	_level += 1
	level_changed.emit(_level)

##Fonction renvoyant la valeur du niveau.
func get_level() -> int:
	return _level


## Procédure de mise à jour du nombre d'audits réalisés.
## @params amount Le nombre d'audits à ajouter au compteur.
func add_audits(amount: int) -> void:
	_audits += amount
	finish_audit.emit(amount)

##Fonction renvoyant le nombre d'audits réalisés.
func get_audits() -> int:
	return _audits
