@tool
extends Control
class_name UpgradeButton


signal upgraded

@export var icon: Texture2D
@export var label: Label
@export var upgrade: Upgrade
@export var button: Button
@export var level: ValueLabel
@export var cost: ValueLabel
@export var value: ValueLabel


func _process(_delta: float) -> void:
	# Affichage dans l'éditeur
	if Engine.is_editor_hint():
		if label && upgrade:
			label.text = upgrade.label
		if icon && button:
			button.icon = icon


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	set_process(false)
	if !(upgrade && button && level && cost && value):
		push_error("%s : some @export variables are null" % name)
	# Mise à jour des labels
	if label && upgrade:
		label.text = upgrade.label
		_update_labels()
	if icon && button:
		button.icon = icon
		button.disabled = true
		button.mouse_default_cursor_shape = Control.CURSOR_ARROW
	# Connecter les signaux
	Global.upgrade_points_changed.connect(_on_upgrade_points_changed)
	# Première vérification au lancement
	_on_upgrade_points_changed(Global.get_upgrade_points())


## Procédure handler qui améliore si possible.
func _on_button_pressed() -> void:
	if !upgrade:
		return
	# Améliorer et déclencher la mise à jour via signal
	upgrade.upgrade()
	_update_labels()
	upgraded.emit()


## Procédure de mise à jour des labels.
func _update_labels() -> void:
	if Engine.is_editor_hint():
		return
	if !(upgrade && level && cost && value):
		return
	# Mise à jour
	level.value = upgrade.level
	cost.value = upgrade.get_cost()
	value.value = snappedf(upgrade.get_effect(), 0.1)


## Procédure handler de mise à jour de l'état du bouton en fonction du nombre de points d'amélioration
## @params points Le nombre de points d'amélioration
func _on_upgrade_points_changed(points: int) -> void:
	# Vérifier si on peut acheter
	var can_afford: bool = upgrade.can_upgrade(points)
	
	# Activer ou désactiver le bouton
	button.disabled = !can_afford
	
	# Changer le curseur : Main (POINTING_HAND) si actif, Flèche (ARROW) si inactif
	if can_afford:
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else:
		button.mouse_default_cursor_shape = Control.CURSOR_ARROW
