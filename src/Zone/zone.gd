extends Node2D
class_name Zone


@export var CONFIDENCE_THRESHOLD: int
@export var MAX_AUDITORS: int

var confidence: int = 0
var auditors_number: int = 0


func _ready() -> void:
	if !(CONFIDENCE_THRESHOLD && MAX_AUDITORS):
		push_error("%s : One of the @export variables is not set." % name)


func deploy_auditor() -> void:
	if auditors_number < MAX_AUDITORS:
		auditors_number += 1
		SignalBus.deploy_auditor.emit(self)
