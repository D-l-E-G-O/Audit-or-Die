extends Node


var _upgrade_points: int = 100
var _clicks: float = 1.0


func get_upgrade_points() -> int:
	return _upgrade_points

func set_upgrade_points(value: int) -> void:
	_upgrade_points = value


func get_clicks() -> float:
	return _clicks

func set_clicks(value: float) -> void:
	_clicks = value
