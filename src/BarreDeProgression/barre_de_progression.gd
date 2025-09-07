extends TextureProgressBar
class_name BarreDeProgression


@export var barre_de_regression: TextureProgressBar

signal maximum_atteint

const DUREE_TWEEN: float = 0.5

var tween: Tween


func _ready() -> void:
	"""
	Procédure qui se déclenche dès que la barre de progression entre dans la scene.
	"""
	reset(true)


func ajouter_valeur(valeur: float) -> void:
	"""
	Procédure qui ajoute de la valeur à la barre de progression.
	"""
	value += valeur
	if value == max_value:
		maximum_atteint.emit()


func update_barre_regression() -> void:
	"""
	Procédure qui met à jour la barre de regression.
	"""
	if !barre_de_regression:
		return
	if barre_de_regression.value <= self.value: # Augmentation de la valeur
		barre_de_regression.value = self.value
	else: # Diminution de la valeur
		reset_tween()
		tween.tween_property(barre_de_regression, "value", self.value, DUREE_TWEEN)


func reset(no_signal: bool) -> void:
	"""
	Procédure qui réinitialise la valeur de la barre de progression et de regression.
	"""
	reset_barre(self, no_signal)
	reset_barre(barre_de_regression, no_signal)


static func reset_barre(barre: TextureProgressBar, no_signal: bool) -> void:
	"""
	Procédure qui réinitialise la valeur d'une TextureProgressBar.
	"""
	if !barre:
		return
	if no_signal:
		barre.set_value_no_signal(barre.min_value)
	else:
		barre.value = barre.min_value


func reset_tween() -> void:
	"""
	Procédure qui réinitialise le tween.
	"""
	if tween:
		tween.kill()
	tween = create_tween()


func _on_value_changed(_value: float) -> void:
	"""
	Procédure qui se déclenche dès que la valeur de la barre de progression change.
	"""
	update_barre_regression()
