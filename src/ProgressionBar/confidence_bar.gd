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
	SignalBus.end_trial.connect(_on_end_trial)
	_update_confidence_bar_max_value()


##Procédure qui se déclenche quand l'épreuve de validation de stage se termine.
func _on_end_trial(trial_succeeded: bool) -> void:
	if trial_succeeded:
		reach_next_stage()
	else:
		reset(false)


func reach_next_stage() -> void:
	stage += 1
	_update_confidence_bar_max_value()
	reset(false)


##Procédure qui met à jour le seuil de la barre de confiance en fonction du stage actuel.
func _update_confidence_bar_max_value() -> void:
	self.max_value = STAGE_CONFIG[stage]["stage_threshold"]
	decrease_bar.max_value = self.max_value


##Procédure qui se déclenche quand le seuil de la barre de confiance est atteint.
func _on_maximum_reached() -> void:
	if stage == FINAL_STAGE:
		SignalBus.add_confidence_bar_value.disconnect(add_value)
		return
	SignalBus.start_stage_trial.emit(stage)
