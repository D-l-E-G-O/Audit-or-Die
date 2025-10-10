extends Node
class_name ZoneManager


const PATHFINDING_SCENE: PackedScene = preload("res://src/Pathfinding/pathfinding.tscn")
@onready var info_com: Zone = $InfoCom
@onready var it: Zone = $IT
@onready var civil: Zone = $Civil
@onready var pharma: Zone = $Pharma
@onready var physics: Zone = $Physics


func _ready() -> void:
	SignalBus.add_pathfinding.connect(_on_add_pathfinding)
	SignalBus.add_confidence_bar_value.connect(_on_add_confidence_bar_value)
	SignalBus.update_zone_stats.connect(_on_update_zone_stats)


func _on_add_pathfinding(auditor: Auditor, zone: Zone) -> void:
	var pathfinding: Pathfinding = PATHFINDING_SCENE.instantiate()
	pathfinding.auditor = auditor
	zone.add_child(pathfinding)


func _on_add_confidence_bar_value(value: int, zone: Zone) -> void:
	zone.add_confidence(value)


func _on_update_zone_stats(zone: Zone) -> void:
	match(zone):
		info_com:
			SignalBus.update_info_com_stats.emit()
		it:
			SignalBus.update_it_stats.emit()
		civil:
			SignalBus.update_civil_stats.emit()
		pharma:
			SignalBus.update_pharma_stats.emit()
		physics:
			SignalBus.update_physics_stats.emit()
		_:
			push_error("%s : The specified zone to update doens't exist" % name)
