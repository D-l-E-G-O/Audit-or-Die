extends Node


var App: Node
var Scene: Node
var UI: Node
var current_scene: Node2D = null


func _ready() -> void:
	# Récupérer les noeuds
	App = get_tree().root.get_node("App")
	Scene = App.get_node("SceneRoot")
	UI = App.get_node("UiRoot")
	current_scene = Scene.get_child(0)


## Procédure pour quitter le jeu.
func quit_game() -> void:
	get_tree().quit()
