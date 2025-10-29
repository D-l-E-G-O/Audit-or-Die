extends Control
class_name UpgradeMenu


@onready var upgrade_points: Label = $VBoxContainer/UpgradeContainer/UpgradePoints
@onready var clicks: UpgradeButton = $VBoxContainer/UpgradeContainer/Clicks


func _ready() -> void:
	update_label(0)
	SignalBus.update_upgrade_points.connect(update_label)


func update_label(points: int) -> void:
	upgrade_points.text = "Upgrade points: %d" % points


func _on_clicks_upgraded() -> void:
	Global.set_clicks(clicks.upgrade.get_effect())
