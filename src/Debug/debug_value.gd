extends RefCounted
class_name DebugValue


var _name: String
var _getter: Callable


func _init(name: String, getter: Callable) -> void:
	self._name = name
	self._getter = getter


func get_value() -> Variant:
	return _getter.call()
