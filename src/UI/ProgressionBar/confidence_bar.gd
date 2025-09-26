extends ProgressionBar
class_name ConfidenceBar


const STAGE_CONFIG: Dictionary[int, Dictionary] = {
	1: {
		"stage_threshold": 100
	},
	2: {
		"stage_threshold": 200
	},
	3: {
		"stage_threshold": 500
	},
	4: {
		"stage_threshold": 1000
	}
}

const FINAL_STAGE: int = 4

var stage: int = 1


func _ready() -> void:
	super()
	SignalBus.add_confidence_bar_value.connect(add_value)
	_update_confidence_bar_max_value()


func _on_end_trial(trial_succeeded: bool) -> void:
	if trial_succeeded:
		reach_next_stage()
	else:
		reset(false)


func reach_next_stage() -> void:
	stage += 1
	_update_confidence_bar_max_value()
	reset(false)


func _update_confidence_bar_max_value() -> void:
	self.max_value = STAGE_CONFIG[stage]["stage_threshold"]
	decrease_bar.max_value = self.max_value


func _on_maximum_reached() -> void:
	if stage == FINAL_STAGE:
		SignalBus.add_confidence_bar_value.disconnect(add_value)
		return
	SignalBus.reached_max_confidence.emit()
