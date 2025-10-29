extends Node


var _upgrade_points: int = 0
var _clicks: float = 1.0
var _auto_clicks: float = 0.0


func get_upgrade_points() -> int:
	return _upgrade_points

func set_upgrade_points(value: int) -> void:
	_upgrade_points = value
	SignalBus.update_upgrade_points.emit(_upgrade_points)


func get_clicks() -> float:
	return _clicks

func set_clicks(value: float) -> void:
	_clicks = value


func get_auto_clicks() -> float:
	return _auto_clicks

func set_auto_clicks(value: float) -> void:
	_auto_clicks = value
	SignalBus.update_auto_clicks.emit(_auto_clicks)
