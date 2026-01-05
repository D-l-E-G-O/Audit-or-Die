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
	Global.finish_audit.connect(_play_audit_created_sound)
	Global.level_changed.connect(_play_level_up_sound)
	
	# Récupérer tous les boutons existants dans le groupe
	var buttons = get_tree().get_nodes_in_group("ui_buttons")
	for btn in buttons:
		_connect_button(btn)
	
	# Pour les boutons créés dynamiquement plus tard
	get_tree().node_added.connect(_on_node_added)


func _on_node_added(node: Node) -> void:
	if node.is_in_group("ui_buttons"):
		_connect_button(node)


func _connect_button(node: Node) -> void:
	# Ajouter le son de clic à tous les boutons
	if node is BaseButton:
		node.pressed.connect(_play_click_sound)
	# Ajouter le son d'amélioration à tous les boutons d'amélioration
	if node.is_in_group("upgrade_buttons"):
		node.pressed.connect(_play_upgrade_sound)


## Procédure handler qui joue le son lors du clic sur un bouton.
func _play_click_sound() -> void:
	click_sound_player.play()


## Procédure handler qui joue le son lorsque le joueur gagne un niveau
func _play_level_up_sound(_level: int) -> void:
	level_up_sound_player.play()


## Procédure handler qui joue le son quand un audit est créé
func _play_audit_created_sound(_audits: int) -> void:
	audit_sound_player.play()


## Procédure handler qui joue le son quand le joueur clique sur une amélioration
func _play_upgrade_sound() -> void:
	upgrade_sound_player.play()
