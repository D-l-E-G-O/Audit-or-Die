extends Node2D
class_name TrialManager


func _ready() -> void:
	SignalBus.start_stage_trial.connect(_on_start_stage_trial)


func _on_start_stage_trial(stage: int) -> void:
	print("Starting trial n°%d" % stage)
	visible = true
	get_tree().paused = true


func _on_succeed_button_pressed() -> void:
	visible = false
	get_tree().paused = false
	SignalBus.end_trial.emit(true)


func _on_fail_button_pressed() -> void:
	visible = false
	get_tree().paused = false
	SignalBus.end_trial.emit(false)
