extends Area2D
class_name Overlay

const COULEUR_HOVER: Color = Color(1, 1, 0, 0.3)

@export var tab: TabBar
@export var overlay_polygon: Polygon2D
var collision_polygon: CollisionPolygon2D

var is_hovered: bool = false:
	set(val):
		is_hovered = val
		overlay_polygon.visible = val || is_clicked

var is_clicked: bool = false:
	set(val):
		is_clicked = val
		overlay_polygon.visible = val

func _ready() -> void :
	SignalBus.left_mouse_button_pressed.connect(_on_left_mouse_button_pressed)
	SignalBus.overlay_clicked.connect(_on_overlay_clicked)
	if !overlay_polygon:
		push_error("%s doesn't have an Overlay polygon defined" % name)
		return
	if !tab:
		push_error("%s doesn't have a TabBar defined" % name)
		return
	
	overlay_polygon.color = COULEUR_HOVER
	overlay_polygon.visible = false
	
	tab.visibility_changed.connect(_on_tab_selected)
	
	collision_polygon = CollisionPolygon2D.new()
	collision_polygon.polygon = overlay_polygon.polygon.duplicate()
	add_child(collision_polygon)
	mouse_entered.connect(_on_hovered)
	mouse_exited.connect(_on_hovered)

func _on_hovered() -> void:
	is_hovered = !is_hovered

func activate() -> void:
	is_clicked = true
	SignalBus.overlay_clicked.emit(get_instance_id())

func _on_left_mouse_button_pressed() -> void:
	if is_hovered:
		activate()
		tab.show()

func _on_overlay_clicked(overlay_id: int) -> void:
	if get_instance_id() != overlay_id && is_clicked:
		is_clicked = false

func _on_tab_selected() -> void:
	if tab.visible:
		activate()
