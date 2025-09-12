extends Node2D


@onready var auditors: Node2D = $MainScene/Auditors
@onready var audit_manager: AuditManager = $MainScene/AuditManager
@onready var confidence_bar: ConfidenceBar = $MainScene/ConfidenceBar
@onready var stage: Label = $MainScene/Stage


func _on_confidence_bar_value_changed(value: float) -> void:
	stage.text = "Stage %d (%d/%d)" % [confidence_bar.stage, confidence_bar.value, confidence_bar.max_value]


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("create_audits"):
		for auditor: Auditor in auditors.get_children():
			auditor.create_multiple_audits()
