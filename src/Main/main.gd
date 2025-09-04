extends Node2D


@onready var auditeurs: Node2D = $Auditeurs
@onready var audit_manager: Node2D = $AuditManager


func _on_button_pressed() -> void:
	for auditeur: Auditeur in auditeurs.get_children():
		auditeur.creer_plusieurs_audits()
