extends ProgressionBar
class_name SkillsBar


@onready var label: Label = $Label

var level: int = 0


func _ready() -> void:
	super()
	set_max_value(pow(2, level))
	reset(true)
	SignalBus.finish_audit.connect(add_value)


func _on_maximum_reached(cycles: int) -> void:
	level += cycles
	set_max_value(pow(2, level))
	reset_with_tween()
	label.text = "Skills level: %d" % level
	var upgrade_points: int = Global.get_upgrade_points()
	for i: int in range(cycles):
		upgrade_points += 10 * (level - i)
	Global.set_upgrade_points(upgrade_points)
