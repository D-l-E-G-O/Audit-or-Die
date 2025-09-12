extends CharacterBody2D
class_name Audit


@onready var texture_button: TextureButton = $TextureButton
@onready var timer: Timer = $Timer

const SPEED: int = 30
const LIFETIME: float = 2.0
const TRANSPARENCY_INCREMENT: float = 0.01

var value: int = 0
var corrupted: bool = false


func _ready() -> void:
	_set_random_velocity()
	_init_timer()


func _physics_process(_delta: float) -> void:
	if timer.is_stopped():
		_become_transparent()
	move_and_slide()


func _become_transparent() -> void:
	texture_button.modulate.a -= TRANSPARENCY_INCREMENT
	if texture_button.modulate.a <= 0.0:
		SignalBus.free_audit.emit(self)


##Procédure qui donne un sens de mouvement aléatoire à l'audit.
func _set_random_velocity() -> void:
	var random_rotation: float = randf_range(PI, -PI)
	velocity = Vector2.UP.rotated(random_rotation) * SPEED


func _init_timer() -> void:
	timer.start(LIFETIME)


##Procédure qui se déclenche quand l'utilisateur clique sur le sprite de l'audit.
func _on_texture_button_pressed() -> void:
	SignalBus.collect_audit.emit(self)
