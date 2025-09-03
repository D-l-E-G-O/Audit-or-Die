extends Sprite2D
class_name SpriteCliquable


signal detection_clic


func _input(event: InputEvent) -> void:
	"""
	Procédure qui émet le signal "detection_clic" si le sprite est cliqué.
	"""
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.pressed && mouse_event.button_index == MOUSE_BUTTON_LEFT:
			if get_rect().has_point(to_local(mouse_event.position)):
				detection_clic.emit()
