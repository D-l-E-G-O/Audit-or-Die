extends Range
class_name ProgressionBar


@export var initial_value: float = 0.0
@export var decrease_bar: TextureProgressBar

signal maximum_reached(cycles: int)

const TWEEN_DURATION: float = 0.5

var _tween: Tween


func _ready() -> void:
	# Valeur initiale
	set_value_no_signal(initial_value)
	# Paramètres initiaux
	allow_greater = true
	if decrease_bar:
		decrease_bar.step = self.step
	reset(true)
	# Connecter le signal
	if !value_changed.is_connected(_on_value_changed):
		value_changed.connect(_on_value_changed)


## Procédure d'ajout de valeur.
## @params val La valeur ajoutée.
func add_value(val: float) -> void:
	var total: float = value + val
	# Boucler en gardant le reste si on dépasse le maximum (cycle effectué)
	if total >= max_value:
		value = floori(total) % floori(max_value)
		maximum_reached.emit(total / max_value)
	else:
		value = total


## Procédure d'application d'un ratio.
## @params _ratio Le ratio à appliquer.
func apply_ratio(_ratio: float) -> void:
	add_value((value * _ratio) - value)


## Procédure de mise à jour de la barre de diminution.
func update_decrease_bar() -> void:
	if !decrease_bar:
		return
	if decrease_bar.value <= self.value:
		# Diminution instantanée
		decrease_bar.value = self.value
	else:
		# Diminution progressive
		_get_tween().tween_property(decrease_bar, "value", self.value, TWEEN_DURATION)


## Procédure de réinitialisation.
## @params no_signal N'envoie pas de signal de réinitialisation si true.
func reset(no_signal: bool) -> void:
	# Réinitialiser la barre principale
	_reset_bar(self, no_signal)
	# Réinitialiser la barre de diminution
	_reset_bar(decrease_bar, no_signal)


## Procédure de réinitialisation progressive.
func reset_with_tween() -> void:
	_reset_bar(self, false)


## Procédure de réinitialisation de la barre.
## @params bar La barre à réinitialiser.
## @params no_signal N'envoie pas de signal de réinitialisation si true.
func _reset_bar(bar: Range, no_signal: bool) -> void:
	if !bar:
		return
	# Réinitialiser la barre avec ou sans signal
	if no_signal:
		bar.set_value_no_signal(initial_value)
	else:
		bar.value = initial_value
		value_changed.emit(bar.value)


## Fonction de récupération du Tween.
## @return Le Tween.
func _get_tween() -> Tween:
	# Réinitialiser le Tween s'il existait déjà
	if _tween:
		_tween.kill()
	_tween = create_tween()
	return _tween


## Procédure handler de changement de valeur.
func _on_value_changed(_value: float) -> void:
	update_decrease_bar()


## Procédure de mise à jour de la valeur maximale.
## @params val La nouvelle valeur.
func set_max_value(val: float) -> void:
	if val < min_value:
		push_error("%s: You can't set a max value smaller than the min value." % name)
	max_value = val
	# Mettre à jour la barre de diminution
	if decrease_bar:
		decrease_bar.max_value = val
		decrease_bar.value = val
