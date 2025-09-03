class_name Pool


var _pool: Array = []
var _scene: PackedScene


func _init(scene: PackedScene) -> void:
	"""
	Constructeur de la pool qui prend en paramètre la scene de l'objet contenu dans la pool.
	"""
	_scene = scene


func get_instance() -> Node:
	"""
	Fonction qui renvoie un objet provenant de la pool s'il y en a sinon crée un objet.
	"""
	for objet in _pool:
		if !objet.visible:
			objet.visible = true
			return objet
	var new_objet = _scene.instantiate()
	_pool.append(new_objet)
	return new_objet


func liberer(objet: Node) -> void:
	"""
	Procédure qui libère l'objet en le désactivant plutôt quand le détruisant complètement.
	"""
	objet.visible = false
