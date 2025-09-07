extends Node2D


@onready var auditeurs: Node2D = $MainScene/Auditeurs
@onready var audit_manager: AuditManager = $MainScene/AuditManager
@onready var barre_de_confiance: BarreDeConfiance = $MainScene/BarreDeConfiance
@onready var palier: Label = $MainScene/Palier


func _on_button_pressed() -> void:
	for auditeur: Auditeur in auditeurs.get_children():
		auditeur.creer_plusieurs_audits()


func _on_barre_de_confiance_value_changed(value: float) -> void:
	palier.text = "Palier %d (%d/%d)" % [barre_de_confiance.palier, barre_de_confiance.value, barre_de_confiance.max_value]
