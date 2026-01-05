extends Control
class_name UpgradeMenu


signal cps_visibility_requested(show: bool)

@export var upgrade_points: Label
@export var clicks: UpgradeButton
@export var auditors: UpgradeButton


func _ready() -> void:
	if !(upgrade_points && clicks && auditors):
		push_error("%s : some @export variables are null" % name)
	# Mise à jour du label
	update_label(0)
	# Connecter le signal
	Global.upgrade_points_changed.connect(update_label)


## Procédure de mise à jour du label.
## @params points Le nombre de points d'amélioration.
func update_label(points: int) -> void:
	if !upgrade_points:
		return
	upgrade_points.text = "Points d'amélioration: %d" % points


## Procédure handler d'amélioration des clics.
func _on_clicks_upgraded() -> void:
	if !clicks:
		return
	# Mettre à jour la valeur des clics
	Global.set_clicks(clicks.upgrade.get_effect())


## Procédure handler d'amélioration des auditeurs.
func _on_auditors_upgraded() -> void:
	if !auditors:
		return
	# Mettre à jour la valeur des clics
	Global.set_auto_clicks(auditors.upgrade.get_effect())
	# Afficher les clics par seconde si on améliore pour la première fois
	if auditors.upgrade.level == 1:
		cps_visibility_requested.emit(true)
