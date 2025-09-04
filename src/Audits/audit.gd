extends CharacterBody2D
class_name Audit


@onready var texture_button: TextureButton = $TextureButton
@onready var timer: Timer = $Timer

signal liberer(audit: Audit)

const SPEED: int = 30
const TEMPS_DE_VIE: float = 2.0
const INCREMENT_DE_TRANSPARENCE: float = 0.01

var valeur: int = 0
var corrompu: bool = false


func _ready() -> void:
	"""
	Procédure qui se déclenche dès que l'audit entre dans la scene.
	"""
	_set_velocite_aleatoire()
	_init_timer()


func _physics_process(_delta: float) -> void:
	"""
	Procédure déclenchée chaque frame.
	"""
	if timer.is_stopped():
		_rendre_invisible()
	move_and_slide()


func _rendre_invisible() -> void:
	texture_button.modulate.a -= INCREMENT_DE_TRANSPARENCE
	if texture_button.modulate.a <= 0.0:
		liberer.emit(self)


func _set_velocite_aleatoire() -> void:
	"""
	Procédure qui donne un sens de mouvement aléatoire à l'audit.
	"""
	var rotation_random: float = randf_range(PI, -PI)
	velocity = Vector2.UP.rotated(rotation_random) * SPEED


func _init_timer() -> void:
	"""
	Procédure qui initialise le timer.
	"""
	timer.start(TEMPS_DE_VIE)


func _on_texture_button_pressed() -> void:
	"""
	Procédure qui se déclenche quand l'utilisateur clique sur le sprite de l'audit.
	"""
	liberer.emit(self)
