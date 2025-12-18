extends Node
class_name AudioRoot


@export var click_sound_player: AudioStreamPlayer2D
@export var audit_sound_player: AudioStreamPlayer2D
@export var level_up_sound_player: AudioStreamPlayer2D
@export var background_music_player: AudioStreamPlayer2D
@export var upgrade_sound_player: AudioStreamPlayer2D


func _ready() -> void:
	if !click_sound_player: push_error("Click sound player is not connected !")
	if !audit_sound_player: push_error("Audit sound player is not connected !")
	if !level_up_sound_player: push_error("Level Up sound player is not connected !")
	if !background_music_player: push_error("Background music player is not connected !")
	if !upgrade_sound_player: push_error("Upgrade sound player is not connected !")
	# Connecter les signaux pour jouer les sons
	SignalBus.button_pressed.connect(_on_button_pressed)
	SignalBus.finish_audit.connect(_on_audit_finished)
	SignalBus.level_up.connect(_on_level_up)
	SignalBus.upgrade.connect(_on_upgrade)


## Procédure handler qui joue le son lors du clic sur un bouton.
func _on_button_pressed() -> void:
	click_sound_player.play()


## Procédure handler qui joue le son lorsque le joueur gagne un niveau
func _on_level_up(_level: int) -> void:
	level_up_sound_player.play()


## Procédure handler qui joue le son quand un audit est créé
func _on_audit_finished(_audits: int) -> void:
	audit_sound_player.play()


## Procédure handler qui joue le son quand le joueur clique sur une amélioration
func _on_upgrade() -> void:
	upgrade_sound_player.play()
