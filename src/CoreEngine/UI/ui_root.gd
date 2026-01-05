extends Node


@export var main_menu: MainMenu
@export var main_ui: Control


func _ready() -> void:
	# UiRoot écoute ses enfants et agit en conséquence
	if !(main_menu && main_ui):
		push_error("%s : some @export variables are null" % name)
		return
	main_menu.play_requested.connect(_on_play_requested)
	main_ui.main_menu_requested.connect(_on_main_menu_requested)


## Procédure handler pour afficher l'interface de jeu.
func _on_play_requested() -> void:
	main_menu.hide()
	main_ui.show()


## Procédure handler pour afficher le menu.
func _on_main_menu_requested() -> void:
	main_ui.hide()
	main_menu.show()
