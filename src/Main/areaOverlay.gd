extends Area2D

@export var couleur_hover : Color = Color(1, 1, 0, 0.3)
@export var couleur_defaut : Color = Color(1, 1, 1, 0)

@onready var poly : Polygon2D = get_parent()
var collision : CollisionPolygon2D

func _ready():
	# Crée le CollisionPolygon2D si nécessaire
	if not has_node("CollisionPolygon2D"):
		collision = CollisionPolygon2D.new()
		add_child(collision)
	else:
		collision = $CollisionPolygon2D
	
	# Copier la forme du Polygon2D
	collision.polygon = poly.polygon.duplicate()
	
	poly.color = couleur_defaut
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	poly.color = couleur_hover

func _on_mouse_exited():
	poly.color = couleur_defaut
