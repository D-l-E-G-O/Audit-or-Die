@tool
extends HBoxContainer
class_name ValueLabel


@export var value: float = 0:
	set(val):
		value = val
		update_value()

@export var text: String = "Value: ":
	set(val):
		text = val
		update_text()

@export var font_size: int = 20:
	set(val):
		font_size = max(1, val)
		update_font_size()

@onready var text_label: Label = $Text
@onready var value_label: Label = $Value

var visibility: bool = true


func _process(_delta: float) -> void:
	# Affichage dans l'éditeur
	if Engine.is_editor_hint():
		update_value()
		update_text()
		update_font_size()


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	set_process(false)
	# Mise à jour de l'affichage
	update_value()
	update_text()
	update_font_size()
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_FILL
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	text_label.size_flags_horizontal = Control.SIZE_FILL
	value_label.size_flags_horizontal = Control.SIZE_SHRINK_END


## Procédure de mise à jour de la valeur.
func update_value() -> void:
	if !value_label:
		return
	if !visibility:
		# Cacher le label
		value_label.text = ""
		return
	# Mise à jour du label
	if int(value) == value:
		value_label.text = str(int(value))
	else:
		value_label.text = str(snappedf(value, 0.01))


## Procédure de mise à jour du texte.
func update_text() -> void:
	if !text_label:
		return
	if !visibility:
		# Cacher le texte
		text_label.text = ""
		return
	# Mise à jour du texte
	text_label.text = text


## Procédure de mise à jour de la taille de police.
func update_font_size() -> void:
	# Valeur
	if value_label:
		value_label.add_theme_font_size_override("font_size", font_size)
	# Texte
	if text_label:
		text_label.add_theme_font_size_override("font_size", font_size)


## Procédure de mise à jour de la visibilité.
## @params new_visibility Le nouvel état de visibilité, vrai pour visible, faux pour invisible.
func set_visibility(new_visibility: bool) -> void:
	# Mise à jour
	visibility = new_visibility
	# Mise à jour de la valeur et du texte
	update_value()
	update_text()
