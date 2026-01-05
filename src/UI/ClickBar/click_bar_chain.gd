extends HBoxContainer
class_name ClickBarChain

const click_bar_display_scene: PackedScene = preload("res://src/UI/ClickBar/click_bar_display.tscn")

@export var auto_click_manager: AutoClickManager

var chain: Array[ClickBarDisplay] = []
var identifiers: Array[int] = []

var clicks_config: Array = [
	[10],
	[10, 5],
	[5, 10, 5],
	[5, 7, 7, 5],
	[3, 6, 12, 6, 3]
]
var color_config: Array[Color] = [
	Color.BLUE, Color.GREEN, Color.RED, Color.YELLOW, Color.CYAN
]
var label_config: Array[String] = [
	"Planification", "Travail sur le terrain", "Evaluations et contrôles", "Revue qualité", "Rapport d'audit"
]


func _ready() -> void:
	if !auto_click_manager:
		push_error("%s: @export var auto_click_manager is undefined" % name)
	# Supprimer la preview
	for click_bar_display in get_children():
		if click_bar_display is ClickBarDisplay:
			click_bar_display.queue_free()
	# Connecter les signaux
	Global.level_changed.connect(_on_level_up)
	# Créer la chaine de ClickBarDisplay
	create_chain(0)
	chain[0].click_bar.set_interactable(true)
	chain[0].hide_cycles = true
	chain[0].update_cycles_label()


## Procédure qui crée la chaine selon le niveau de configuration.
## @params level Niveau de la configuration de la chaine à créer.
func create_chain(level: int) -> void:
	# Mettre à jour tous les ClickBarDisplay existant
	for i:int in range(level):
		var click_bar_display: ClickBarDisplay = chain[i]
		click_bar_display.color = color_config[i]
		click_bar_display.required_clicks = clicks_config[level][i]
		click_bar_display.label = label_config[i]
		click_bar_display.update_click_bar()
	# Ajouter le nouveau ClickBarDisplay
	add_new_click_bar_display(level)


## Procédure d'ajout d'un nouveau ClickBarDisplay selon le niveau de configuration.
## @params config_index Niveau de la configuration du ClickBarDisplay à créer.
func add_new_click_bar_display(config_index: int) -> void:
	# Création
	var click_bar_display: ClickBarDisplay = click_bar_display_scene.instantiate()
	click_bar_display.color = color_config[config_index]
	click_bar_display.required_clicks = clicks_config[config_index][config_index]
	click_bar_display.label = label_config[-1]
	click_bar_display.click_bar.set_interactable(false)
	# Ajout dans la scène
	add_child(click_bar_display)
	# Ajout dans la liste et liaison du signal
	chain.append(click_bar_display)
	identifiers.append(click_bar_display.click_bar.get_instance_id())
	click_bar_display.click_bar.cycle_completed.connect(_on_cycle_completed)
	# Ajout au gestionnaire de clic passif
	if auto_click_manager:
		auto_click_manager.add_new_click_bar_display(click_bar_display)

## Procédure handler de complétion de cycle.
## @params id Identifiant d'instance du ClickBarDisplay dont le cycle est complété.
## @params cycles Nombre de cycles complétés par le ClickBarDisplay.
func _on_cycle_completed(id: int, cycles: int) -> void:
	# Trouver le ClickBarDisplay correspondant
	var click_bar_index: int = identifiers.find(id)
	if click_bar_index == -1:
		push_error("Click Bar not found")
		return
	if click_bar_index > 0:
		cycles = min(cycles, chain[click_bar_index].cycles)
	# Si le ClickBar display n'est pas le dernier de la chaine: Ajouter les cycles au ClickBarDisplay suivant
	if click_bar_index < chain.size() - 1:
		add_cycle(click_bar_index + 1, cycles)
	# Sinon
	else:
		Global.add_audits(cycles)
	# Mettre à jour le ClickBarDisplay
	end_cycle(click_bar_index, cycles)


## Procédure qui ajoute des cycles à un ClickBarDisplay.
## @params next_index Indice du ClickBarDisplay cible.
## @params cycles Nombre de cycles à ajouter.
func add_cycle(next_index: int, cycles: int) -> void:
	# Récupérer le ClickBarDisplay
	var click_bar_display: ClickBarDisplay = chain[next_index]
	# Ajouter les cycles
	click_bar_display.cycles += cycles
	# Mettre à jour l'affichage
	if click_bar_display.cycles > 0:
		click_bar_display.click_bar.set_interactable(true)


## Procédure de mise à jour d'un ClickBarDisplay à la fin d'un cycle.
## @params click_bar_index Indice du ClickBarDisplay cible.
## @params cycles Nombre de cycles effectués.
func end_cycle(click_bar_index: int, cycles: int) -> void:
	# Récupérer le ClickBarDisplay
	if click_bar_index == 0:
		return
	var click_bar_display: ClickBarDisplay = chain[click_bar_index]
	# Décrémenter le compteur de cycles
	click_bar_display.cycles -= cycles
	# Mettre à jour l'affichage si tous les cycles ont été effectués
	if click_bar_display.cycles <= 0:
		var click_bar: ClickBar = click_bar_display.click_bar
		click_bar.call_deferred("reset", true)
		click_bar.set_interactable(false)


## Procédure de synchronisation des ClickBarDisplay.
func synchronize_click_bars() -> void:
	# Synchroniser les ClickBarDisplay par rapport au ClickBarDisplay le moins avancé
	var min_value: float = get_smallest_click_bar_value()
	for display: ClickBarDisplay in chain:
		display.click_bar.set_value(min_value)


## Fonction rencoyant la valeur de l'avancement minimal parmi les ClickBarDisplay.
## @returns float La valeur de l'avancement minimal.
func get_smallest_click_bar_value() -> float:
	# Valeur minimale par défaut
	var min_value: float = chain[0].click_bar.get_value()
	# Parcourir tous les ClickBar pour récupérer le minimum
	for i: int in range(1, chain.size()):
		var click_bar: ClickBar = chain[i].click_bar
		min_value = min(min_value, click_bar.get_value())
	return min_value

## Procédure handler du passage à niveau.
## @params level Nouveau niveau.
func _on_level_up(level: int) -> void:
	# Mettre à jour la configuration de la chaine de ClickBarDisplay 
	if level >= clicks_config.size(): return
	create_chain(level)
