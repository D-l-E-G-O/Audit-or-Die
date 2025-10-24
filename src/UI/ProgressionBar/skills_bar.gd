extends ProgressionBar
class_name SkillsBar


#var decrease_per_second: float = 5.0


func _ready() -> void:
	super()
	SignalBus.add_skills_bar_value.connect(add_value)


#func _physics_process(delta: float) -> void:
	#add_value(-decrease_per_second * delta)
