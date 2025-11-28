extends Control
class_name MainMenu


signal show_main_ui


func _ready() -> void:
	SignalBus.show_main_menu.connect(show)


func _on_play_pressed() -> void:
	visible = false
	show_main_ui.emit()


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	Game.quit_game()
