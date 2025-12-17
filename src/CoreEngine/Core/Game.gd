extends Node


var App: Node
var Scene: Node
var UI: Node
var current_scene: Node2D = null


func _ready() -> void:
	# Définir les images de curseur de la souris
	var cursor_default = preload("res://assets/cursors/hand_cursor.png")
	var cursor_hover = preload("res://assets/cursors/hand_hover_cursor.png")
	Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(12, 0))
	Input.set_custom_mouse_cursor(cursor_hover, Input.CURSOR_POINTING_HAND, Vector2(12, 7))
	# Récupérer les noeuds
	App = get_tree().root.get_node("App")
	Scene = App.get_node("SceneRoot")
	UI = App.get_node("UiRoot")
	current_scene = Scene.get_child(0)


## Procédure pour quitter le jeu.
func quit_game() -> void:
	get_tree().quit()
