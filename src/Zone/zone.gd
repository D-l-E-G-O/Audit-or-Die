extends Node2D
class_name Zone


@export var CONFIDENCE_THRESHOLD: int
@export var MAX_AUDITORS: int

var confidence: int = 0:
	set(val):
		confidence = min(max(0, val), CONFIDENCE_THRESHOLD)
		SignalBus.update_zone_stats.emit(self)

var auditors_number: int = 0:
	set(val):
		auditors_number = min(val, MAX_AUDITORS)
		SignalBus.update_zone_stats.emit(self)


func _ready() -> void:
	if !(CONFIDENCE_THRESHOLD && MAX_AUDITORS):
		push_error("%s : One of the @export variables is not set." % name)


func deploy_auditor() -> void:
	if auditors_number < MAX_AUDITORS:
		auditors_number += 1
		SignalBus.deploy_auditor.emit(self)


func add_confidence(value: int) -> void:
	confidence += value
