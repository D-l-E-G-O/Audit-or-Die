extends Control
class_name UpgradeButton


signal upgraded

@export var upgrade: Upgrade
@onready var button: Button = $Button
@onready var level_label: Label = $GridContainer/Level
@onready var cost_label: Label = $GridContainer/Cost
@onready var value_label: Label = $GridContainer/Value


func _ready() -> void:
	if upgrade:
		button.text = upgrade.label
		_update_labels()
	else:
		push_error("%s: the upgrade @export variable is not defined" % name)


func _on_button_pressed() -> void:
	if !upgrade:
		return
	if upgrade.can_upgrade(Global.get_upgrade_points()):
		upgrade.upgrade()
		_update_labels()
		upgraded.emit()


func _update_labels() -> void:
	level_label.text = "Level: %d" % upgrade.level
	cost_label.text = "Cost: %d" % upgrade.get_cost()
	value_label.text = "Value: %0.2f" % snappedf(upgrade.get_effect(), 0.1)
