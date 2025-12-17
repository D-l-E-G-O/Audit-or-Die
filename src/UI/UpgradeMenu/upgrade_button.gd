@tool
extends Control
class_name UpgradeButton


signal upgraded

@export var upgrade: Upgrade
@export var button: Button
@export var level: ValueLabel
@export var cost: ValueLabel
@export var value: ValueLabel


func _process(_delta: float) -> void:
	# Affichage dans l'éditeur
	if Engine.is_editor_hint():
		if button && upgrade:
			button.text = upgrade.label


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	set_process(false)
	if !(upgrade && button && level && cost && value):
		push_error("%s : some @export variables are null" % name)
	# Mise à jour des labels
	if button && upgrade:
		button.text = upgrade.label
		_update_labels()


## Procédure handler qui améliore si possible.
func _on_button_pressed() -> void:
	if !upgrade:
		return
	# Améliorer si possible et déclencher la mise à jour via signal
	if upgrade.can_upgrade(Global.get_upgrade_points()):
		upgrade.upgrade()
		_update_labels()
		upgraded.emit()


## Procédure de mise à jour des labels.
func _update_labels() -> void:
	if Engine.is_editor_hint():
		return
	if !(upgrade && level && cost && value):
		return
	# Mise à jour
	level.value = upgrade.level
	cost.value = upgrade.get_cost()
	value.value = snappedf(upgrade.get_effect(), 0.1)
