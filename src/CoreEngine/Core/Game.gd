extends Node


func _ready() -> void:
	# Définir les images de curseur de la souris
	var cursor_default = preload("res://assets/cursors/hand_cursor.png")
	var cursor_hover = preload("res://assets/cursors/hand_hover_cursor.png")
	Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(12, 0))
	Input.set_custom_mouse_cursor(cursor_hover, Input.CURSOR_POINTING_HAND, Vector2(12, 7))


## Procédure pour quitter le jeu.
func quit_game() -> void:
	get_tree().quit()
