extends Control


signal main_menu_requested

@export var upgrade_menu: UpgradeMenu
@export var sync_click_bars: Button
@export var click_bar_chain: ClickBarChain


func _ready() -> void:
	if !(sync_click_bars && click_bar_chain && upgrade_menu):
		push_error("%s : some @export variables are null" % name)
	# Cacher le bouton de synchronisation
	if sync_click_bars:
		sync_click_bars.hide()
	# Connecter le signal
	upgrade_menu.cps_visibility_requested.connect(_on_set_cps_info_visibility)


## Procédure handler d'affichage des informations.
func _on_show_infos_check_button_toggled(toggled_on: bool) -> void:
	toggled_on = toggled_on
	# Pas implémenté


## Procédure handler d'affichage du menu principal.
func _on_back_to_menu_pressed() -> void:
	# Emettre le signal d'affichage du menu
	main_menu_requested.emit()


## Procédure handler de synchronisation des ClickBar.
func _on_sync_click_bars_pressed() -> void:
	# Emettre le signal de synchronisation
	click_bar_chain.synchronize_click_bars()


## Procédure handler de mise à jour de l'affichage des info des clics par seconde.
## @params show_button Affiche les infos si true, sinon les cache.
func _on_set_cps_info_visibility(show_button: bool) -> void:
	if sync_click_bars:
		sync_click_bars.visible = show_button
