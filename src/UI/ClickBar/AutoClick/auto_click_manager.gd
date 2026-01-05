extends Node
class_name AutoClickManager


var clickbars: Array[ClickBarDisplay] = []


func _ready() -> void:
	# Connecter le signal
	Global.auto_clicks_changed.connect(_on_update_auto_clicks)


func _physics_process(delta: float) -> void:
	# Augmenter progressivement les ClickBarDisplay
	for click_bar_display: ClickBarDisplay in clickbars:
		# Erreur si les clics par seconde sont inférieurs à 0
		if click_bar_display.cps < 0:
			push_error("%s : ClickBarDisplay %s isn't registered in the dictionnary" % [name, click_bar_display.name])
			clickbars.erase(click_bar_display)
		elif !click_bar_display.click_bar.disabled:
			click_bar_display.click_bar.add_value(click_bar_display.cps * delta)


## Procédure qui ajoute un nouveau ClickBarDisplay passé en paramètre à la liste des clickbars.
## @params click_bar_display Le nouveau ClickBarDisplay.
func add_new_click_bar_display(click_bar_display: ClickBarDisplay) -> void:
	# Ajouter un nouveau ClickBarDisplay
	clickbars.append(click_bar_display)
	# Connecter le signal
	click_bar_display.distribution_bar.value_updated.connect(_on_distribution_bar_value_updated)


## Procédure handler du signal de mise à jour des clics passifs.
## @params value La valeur des clicks passifs.
func _on_update_auto_clicks(value: float) -> void:
	# Mettre à jour la distribution
	if _get_distribution_percentage_remainder(-1) == 100.0:
		clickbars[0].distribution_bar.value = 100.0
		_on_distribution_bar_value_updated(clickbars[0].distribution_bar)
	else:
		update_all_cps()


## Procédure handler du signal de changement de la distribution des clics passifs.
## @params bar La barre de distribution.
func _on_distribution_bar_value_updated(bar: DistributionBar) -> void:
	# Mettre à jour la distribution
	var max_value: float = _get_distribution_percentage_remainder(bar.get_instance_id())
	bar.value = clampf(bar.value, 0.0, max_value)
	update_cps(bar.get_instance_id(), bar.value)


## Fonction qui renvoie un flottant correspondant au pourcentage restant de répartition des clics passifs.
## @params bar_id L'identifiant d'instance de la barre de distribution.
## @return float Le pourcentage de répartition restant.
func _get_distribution_percentage_remainder(bar_id: int) -> float:
	var total_remainder: float = 100
	# Calculer le reste
	for click_bar_display: ClickBarDisplay in clickbars:
		var distribution_bar: DistributionBar = click_bar_display.distribution_bar
		if distribution_bar.get_instance_id() != bar_id:
			total_remainder -= distribution_bar.value
	return total_remainder


## Procédure qui met à jour les clics par seconde d'un certain ClickBarDisplay.
## @params bar_id L'identifiant d'instance de la barre de distribution du ClickBarDisplay recherché.
##         value La valeur des clics par seconde du ClickBarDiplay recherché.
func update_cps(bar_id: int, value: float) -> void:
	var n: int = clickbars.size()
	var i: int = 0
	var found: bool = false
	# Retrouver le ClickBarDisplay
	while i<n && !found:
		var click_bar_display: ClickBarDisplay = clickbars[i]
		var distribution_bar: DistributionBar = click_bar_display.distribution_bar
		if distribution_bar.get_instance_id() == bar_id:
			click_bar_display.cps = Global.get_auto_clicks() * (value / 100)
			found = true
		else:
			i += 1
	if !found:
		push_error("%s : The ClickBarDisplay wasn't found" % name)


## Procédure qui met à jour l'affichage des clics par seconde de chaque ClickBarDisplay.
func update_all_cps() -> void:
	for click_bar_display: ClickBarDisplay in clickbars:
		var value: float = click_bar_display.distribution_bar.value
		click_bar_display.cps = Global.get_auto_clicks() * (value / 100)
