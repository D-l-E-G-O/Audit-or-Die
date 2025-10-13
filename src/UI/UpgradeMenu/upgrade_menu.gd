extends Control
class_name UpgradeMenu


@export var zone_manager: ZoneManager
@export var info_com_overlay: Overlay
@export var it_overlay: Overlay
@export var civil_overlay: Overlay
@export var pharma_overlay: Overlay
@export var physics_overlay: Overlay

@onready var confidence_info_com: Label = $MarginContainer/VBoxContainer/TabContainer/InfoCom/Confidence_InfoCom
@onready var auditors_info_com: Label = $MarginContainer/VBoxContainer/TabContainer/InfoCom/Auditors_InfoCom

@onready var confidence_it: Label = $MarginContainer/VBoxContainer/TabContainer/IT/Confidence_IT
@onready var auditors_it: Label = $MarginContainer/VBoxContainer/TabContainer/IT/Auditors_IT


func _ready() -> void:
	if !zone_manager:
		push_error("Export variable zone manager is not set.")
		return
	SignalBus.update_info_com_stats.connect(_on_update_info_com_stats)
	SignalBus.update_it_stats.connect(_on_update_it_stats)
	SignalBus.update_civil_stats.connect(_on_update_civil_stats)
	SignalBus.update_pharma_stats.connect(_on_update_pharma_stats)
	SignalBus.update_physics_stats.connect(_on_update_physics_stats)
	_on_update_info_com_stats()
	_on_update_it_stats()
	_on_update_civil_stats()
	_on_update_pharma_stats()
	_on_update_physics_stats()


func update_confidence_label(label: Label, zone: Zone) -> void:
	var confidence: int = zone.confidence
	var max_confidence: int = zone.CONFIDENCE_THRESHOLD
	label.text = "Confidence:              %d / %d" % [confidence, max_confidence]


func update_auditors_label(label: Label, zone: Zone) -> void:
	var auditors_number: int = zone.auditors_number
	var max_auditors_number: int = zone.MAX_AUDITORS
	label.text = "%d / %d" % [auditors_number, max_auditors_number]


#region InfoCom

func _on_deploy_auditor_info_com_pressed() -> void:
	if zone_manager:
		zone_manager.info_com.deploy_auditor()

func _on_update_info_com_stats() -> void:
	var zone: Zone = zone_manager.info_com
	update_confidence_label(confidence_info_com, zone)
	update_auditors_label(auditors_info_com, zone)

#endregion


#region IT

func _on_deploy_auditor_it_pressed() -> void:
	if zone_manager:
		zone_manager.it.deploy_auditor()

func _on_update_it_stats() -> void:
	var zone: Zone = zone_manager.it
	update_confidence_label(confidence_it, zone)
	update_auditors_label(auditors_it, zone)

#endregion





func _on_update_civil_stats() -> void:
	pass


func _on_update_pharma_stats() -> void:
	pass


func _on_update_physics_stats() -> void:
	pass
