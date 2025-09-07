extends Node


@warning_ignore_start("unused_signal")


signal creer_audit(valeur_audit: int, proba_corruption: float, position: Vector2)

signal liberer_audit(audit: Audit)

signal recuperer_audit(audit: Audit)

signal ajouter_valeur_barre_confiance(valeur: int)

signal lancer_epreuve_de_validation(palier: int)

signal fin_epreuve(epreuve_reussie: bool)


@warning_ignore_restore("unused_signal")
