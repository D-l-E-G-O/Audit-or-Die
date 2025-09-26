extends Control
class_name UpgradeMenu


@export var zone_manager: ZoneManager


func _ready() -> void:
	if !zone_manager:
		push_error("Export variable zone manager is not set.")


func _on_deploy_auditor_info_com_pressed() -> void:
	if zone_manager:
		zone_manager.info_com.deploy_auditor()
