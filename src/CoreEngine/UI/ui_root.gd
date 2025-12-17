extends Node


@onready var main_ui: Control = $CanvasLayer/MainUI


## Procédure handler pour afficher l'interface principale.
func _on_main_menu_show_main_ui() -> void:
	main_ui.show()
