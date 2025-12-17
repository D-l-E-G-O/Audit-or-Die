@tool
extends Button
class_name ClickBar


signal cycle_completed(id: int, cycles: int)

@export var color: Color = Color(0.6, 0.6, 0.6)
@export var required_clicks: int = 3

@onready var progress_bar: ProgressionBar = $ProgressBar


func _process(_delta: float) -> void:
	# Affichage dans l'éditeur
	if Engine.is_editor_hint():
		update_color()


func _ready() -> void:
	# Mise à jour au lancement du jeu
	if Engine.is_editor_hint():
		return
	set_process(false)
	update_color()


## Procédure qui met à jour la couleur de la barre de progression.
func update_color() -> void:
	if !progress_bar: return
	# Mise à jour
	var style_box = StyleBoxFlat.new()
	style_box.set_corner_radius_all(5)
	style_box.bg_color = color
	progress_bar.add_theme_stylebox_override("fill", style_box)


## Procédure qui ajoute de la valeur en fonction du nombre de clicks.
## @params nb_clicks Le nombre de clics.
func add_value(nb_clicks: float) -> void:
	if nb_clicks > 0:
		# Valeur ajoutée = valeur max * (clics / clics requis) + sécurité
		progress_bar.add_value(progress_bar.max_value * (nb_clicks / required_clicks) + 0.01)


## Procédure qui met à jour la valeur de la barre de progression.
## @params value La nouvelle valeur.
func set_value(value: float) -> void:
	progress_bar.value = value


## Fonction qui renvoie la valeur de la barre de progression.
## @return float La valeur.
func get_value() -> float:
	return progress_bar.value


## Procédure handler du clic.
func _on_pressed() -> void:
	# Ajouter la valeur correspondant aux clics
	add_value(Global.get_clicks())


## Procédure handler du signal du maximum atteint.
func _on_progress_bar_maximum_reached(cycles: int) -> void:
	# Emettre le signal
	cycle_completed.emit(get_instance_id(), cycles)

## Procédure qui réinitialise la barre de progression.
## @params bool Emettre un signal lors de la réinitialisation si true.
func reset(no_signal: bool) -> void:
	progress_bar.reset(no_signal)
