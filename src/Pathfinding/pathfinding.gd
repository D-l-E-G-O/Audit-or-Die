extends PathFollow2D
class_name Pathfinding


var auditor: Auditor
var speed: int = 100


func _physics_process(delta: float) -> void:
	if auditor:
		progress += speed * delta
		auditor.global_position = global_position
