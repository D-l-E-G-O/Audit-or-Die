extends Node
class_name ZoneManager


const PATHFINDING_SCENE: PackedScene = preload("res://src/Pathfinding/pathfinding.tscn")


func _ready() -> void:
	SignalBus.add_pathfinding.connect(_on_add_pathfinding)


func _on_add_pathfinding(auditor: Auditor, zone: Zone) -> void:
	var pathfinding: Pathfinding = PATHFINDING_SCENE.instantiate()
	pathfinding.auditor = auditor
	zone.add_child(pathfinding)
