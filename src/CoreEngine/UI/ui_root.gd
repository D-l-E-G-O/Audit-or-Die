extends Node


@onready var main_ui: Control = $CanvasLayer/MainUI


func _on_main_menu_show_main_ui() -> void:
	main_ui.show()
