extends Control
class_name MainMenu


signal show_main_ui


func _ready() -> void:
	# Connecter le signal
	SignalBus.show_main_menu.connect(show)


## Procédure handler quand le joueur démarre le jeu.
func _on_play_pressed() -> void:
	visible = false
	# Emettre le signal
	show_main_ui.emit()
	SignalBus.button_pressed.emit()


## Procédure handler quand le joueur ouvre les paramètres.
func _on_settings_pressed() -> void:
	SignalBus.button_pressed.emit()
	pass # Pas encore implémenté


## Procédure handler quand le joueur quitte la partie.
func _on_quit_pressed() -> void:
	Game.quit_game()
