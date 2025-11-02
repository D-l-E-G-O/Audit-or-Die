extends Control
class_name UpgradeMenu


@onready var upgrade_points: Label = $VBoxContainer/UpgradeContainer/UpgradePoints
@onready var clicks: UpgradeButton = $VBoxContainer/UpgradeContainer/Clicks
@onready var auditors: UpgradeButton = $VBoxContainer/UpgradeContainer/Auditors


func _ready() -> void:
	update_label(0)
	SignalBus.update_upgrade_points.connect(update_label)


func update_label(points: int) -> void:
	upgrade_points.text = "Upgrade points: %d" % points


func _on_clicks_upgraded() -> void:
	Global.set_clicks(clicks.upgrade.get_effect())


func _on_auditors_upgraded() -> void:
	Global.set_auto_clicks(auditors.upgrade.get_effect())
	if auditors.upgrade.level == 1:
		SignalBus.set_cps_info_visibility.emit(true)
