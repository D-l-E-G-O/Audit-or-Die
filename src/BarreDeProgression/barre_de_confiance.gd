extends BarreDeProgression
class_name BarreDeConfiance


const PALIERS_CONFIG: Dictionary[int, Dictionary] = {
	1: {
		"seuil_palier": 100
	},
	2: {
		"seuil_palier": 200
	},
	3: {
		"seuil_palier": 500
	},
	4: {
		"seuil_palier": 1000
	}
}

const PALIER_MAXIMUM: int = 4

var palier: int = 1


func _ready() -> void:
	"""
	Procédure qui se déclenche dès que la barre de confiance entre dans la scene.
	"""
	super()
	SignalBus.ajouter_valeur_barre_confiance.connect(ajouter_valeur)
	SignalBus.fin_epreuve.connect(_on_fin_epreuve)
	update_valeur_max_barre_progression()


func _on_fin_epreuve(epreuve_reussie: bool) -> void:
	"""
	Procédure qui se déclenche quand l'épreuve de validation de palier se termine.
	"""
	if epreuve_reussie:
		atteindre_palier_superieur()
	else:
		reset(false)


func atteindre_palier_superieur() -> void:
	"""
	Procédure qui passe la barre de confiance au palier suivant.
	"""
	palier += 1
	update_valeur_max_barre_progression()
	reset(false)


func update_valeur_max_barre_progression() -> void:
	"""
	Procédure qui met à jour le seuil de la barre de confiance en fonction du palier actuel.
	"""
	self.max_value = PALIERS_CONFIG[palier]["seuil_palier"]
	barre_de_regression.max_value = self.max_value


func _on_maximum_atteint() -> void:
	"""
	Procédure qui se déclenche quand le seuil de la barre de confiance est atteint.
	"""
	if palier == PALIER_MAXIMUM:
		SignalBus.ajouter_valeur_barre_confiance.disconnect(ajouter_valeur)
		return
	SignalBus.lancer_epreuve_de_validation.emit(palier)
