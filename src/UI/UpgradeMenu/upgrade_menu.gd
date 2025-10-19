extends Control
class_name UpgradeMenu


@onready var upgrade_container: VBoxContainer = $VBoxContainer/UpgradeContainer
@onready var upgrade_points: Label = $VBoxContainer/UpgradeContainer/UpgradePoints
@onready var clicks: UpgradeButton = $VBoxContainer/UpgradeContainer/Clicks


func _ready() -> void:
	update_label()
	for child: Control in upgrade_container.get_children():
		if child is UpgradeButton:
			child.upgraded.connect(update_label)


func update_label() -> void:
	upgrade_points.text = "Upgrade points: %d" % Global.get_upgrade_points()


func _on_clicks_upgraded() -> void:
	Global.set_clicks(clicks.upgrade.get_effect())
