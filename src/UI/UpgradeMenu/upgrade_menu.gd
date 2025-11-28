extends Control
class_name UpgradeMenu


@export var upgrade_points: Label
@export var clicks: UpgradeButton
@export var auditors: UpgradeButton


func _ready() -> void:
	if !(upgrade_points && clicks && auditors):
		push_error("%s : some @export variables are null" % name)
	update_label(0)
	SignalBus.update_upgrade_points.connect(update_label)


func update_label(points: int) -> void:
	if !upgrade_points:
		return
	upgrade_points.text = "Upgrade points: %d" % points


func _on_clicks_upgraded() -> void:
	if !clicks:
		return
	Global.set_clicks(clicks.upgrade.get_effect())


func _on_auditors_upgraded() -> void:
	if !auditors:
		return
	Global.set_auto_clicks(auditors.upgrade.get_effect())
	if auditors.upgrade.level == 1:
		SignalBus.set_cps_info_visibility.emit(true)
