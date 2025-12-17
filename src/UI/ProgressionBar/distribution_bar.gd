extends ProgressBar
class_name DistributionBar


signal value_updated(bar: DistributionBar)

var _dragging: bool = false


func _ready() -> void:
	# Minimum initial
	value = min_value

func _gui_input(event: InputEvent) -> void:
	# Clic gauche -> mise à jour instantanée
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				_dragging = true
				_update_value_from_mouse(event.position.x)
			else:
				_dragging = false
	# Déplacement -> mise à jour continue
	elif event is InputEventMouseMotion and _dragging:
		_update_value_from_mouse(event.position.x)


## Procédure de mise à jour de la valeur en fonction de la position de la souris.
## @params mouse_x Position horizontale de la souris.
func _update_value_from_mouse(mouse_x: float) -> void:
	var _ratio: float = clamp(mouse_x / size.x, 0.0, 1.0)
	var new_val: float = lerp(min_value, max_value, _ratio)
	# Sécurité
	if abs(value - new_val) > 0.001:
		value = new_val
		value_updated.emit(self)
