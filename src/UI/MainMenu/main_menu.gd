extends Control
class_name MainMenu


signal play_requested
signal settings_requested


## Procédure handler quand le joueur démarre le jeu.
func _on_play_pressed() -> void:
	visible = false
	# Emettre le signal
	play_requested.emit()


## Procédure handler quand le joueur ouvre les paramètres.
func _on_settings_pressed() -> void:
	# Emettre le signal
	settings_requested.emit()


## Procédure handler quand le joueur quitte la partie.
func _on_quit_pressed() -> void:
	Game.quit_game()
