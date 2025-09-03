extends CharacterBody2D
class_name Audit


@onready var sprite_cliquable: SpriteCliquable = $SpriteCliquable

var valeur: int = 0
var corrompu: bool = false


func _on_sprite_cliquable_detection_clic() -> void:
	"""
	Procédure qui est activée quand l'utilisateur clique sur le sprite de l'audit.
	"""
	AuditManager.liberer_audit(self)
