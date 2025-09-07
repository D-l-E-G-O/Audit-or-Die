extends Node2D
class_name EpreuveManager


func _ready() -> void:
	SignalBus.lancer_epreuve_de_validation.connect(lancer_epreuve_de_validation)


func lancer_epreuve_de_validation(palier: int) -> void:
	print("Lancement Epreuve n°%d" % palier)
	visible = true
	get_tree().paused = true


func _on_bouton_reussir_pressed() -> void:
	visible = false
	get_tree().paused = false
	SignalBus.fin_epreuve.emit(true)


func _on_bouton_echouer_pressed() -> void:
	visible = false
	get_tree().paused = false
	SignalBus.fin_epreuve.emit(false)
