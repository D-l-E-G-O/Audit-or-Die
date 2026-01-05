extends ProgressionBar
class_name SkillsBar


@export var label: Label

var level: int = 0


func _ready() -> void:
	# Appel au parent
	super()
	# Valeur maximale initiale
	set_max_value(pow(2, level))
	# Reinitialisation
	reset(true)
	# Connecter le signal
	Global.finish_audit.connect(add_value)


## Procédure handler d'atteinte du maximum
## @params cycles Le nombre de cycles complétés
func _on_maximum_reached(cycles: int) -> void:
	# Mettre à jour le niveau
	level += cycles
	# Mettre à jour la valeur maximale en fonction du niveau
	set_max_value(pow(2, level))
	# Reinitialisation progressive
	reset_with_tween()
	# Mise à jour du label
	if label:
		label.text = "Niveau de compétence: %d" % level
	# Récupérer et ajouter les points d'amélioration
	var upgrade_points: int = Global.get_upgrade_points()
	for i: int in range(cycles):
		upgrade_points += 10 * (level - i)
	# Augmenter le niveau
	Global.level_up()
	# Mettre à jour les points d'amélioration
	Global.set_upgrade_points(upgrade_points)
