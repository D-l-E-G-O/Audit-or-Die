extends HBoxContainer
class_name ClickBarChain

const click_bar_display_scene: PackedScene = preload("res://src/UI/ClickBar/click_bar_display.tscn")

@export var auto_click_manager: AutoClickManager

var chain: Array[ClickBarDisplay] = []
var identifiers: Array[int] = []

var hide_cps: bool = true

var clicks_config: Array = [
	[10],
	[10, 5],
	[5, 10, 5],
	[5, 7, 7, 5],
	[3, 6, 12, 6, 3]
]
var color_config: Array[Color] = [
	Color.BLUE, Color.GREEN, Color.RED, Color.YELLOW, Color.CYAN
]
var label_config: Array[String] = [
	"Planification", "Travail sur le terrain", "Evaluations et contrôles", "Revue qualité", "Rapport d'audit"
]


func _ready() -> void:
	if !auto_click_manager:
		push_error("%s: @export var auto_click_manager is undefined" % name)
	for click_bar_display in get_children():
		if click_bar_display is ClickBarDisplay:
			click_bar_display.queue_free()
	SignalBus.synchronize_click_bars.connect(_on_synchronize_click_bars)
	SignalBus.level_up.connect(_on_level_up)
	SignalBus.set_cps_info_visibility.connect(func(_show: bool): hide_cps = !_show)
	create_chain(0)
	chain[0].click_bar.disabled = false
	chain[0].hide_cycles = true
	chain[0].update_cycles_label()


func create_chain(level: int) -> void:
	for i:int in range(level):
		var click_bar_display: ClickBarDisplay = chain[i]
		click_bar_display.color = color_config[i]
		click_bar_display.required_clicks = clicks_config[level][i]
		click_bar_display.label = label_config[i]
		click_bar_display.hide_cps = hide_cps
		click_bar_display.update_click_bar()
	
	add_new_click_bar_display(level)


func add_new_click_bar_display(config_index: int) -> void:
	var click_bar_display: ClickBarDisplay = click_bar_display_scene.instantiate()
	click_bar_display.color = color_config[config_index]
	click_bar_display.required_clicks = clicks_config[config_index][config_index]
	click_bar_display.label = label_config[-1]
	click_bar_display.hide_cps = hide_cps
	click_bar_display.click_bar.disabled = true
	
	add_child(click_bar_display)
	
	chain.append(click_bar_display)
	identifiers.append(click_bar_display.click_bar.get_instance_id())
	click_bar_display.click_bar.cycle_completed.connect(_on_cycle_completed)
	
	if auto_click_manager:
		auto_click_manager.add_new_click_bar_display(click_bar_display)


func _on_cycle_completed(id: int, cycles: int) -> void:
	var click_bar_index: int = identifiers.find(id)
	if click_bar_index == -1:
		push_error("Click Bar not found")
		return
	if click_bar_index > 0:
		cycles = min(cycles, chain[click_bar_index].cycles)
	if click_bar_index < chain.size() - 1:
		add_cycle(click_bar_index + 1, cycles)
	else:
		SignalBus.finish_audit.emit(cycles)
	end_cycle(click_bar_index, cycles)


func add_cycle(next_index: int, cycles: int) -> void:
	var click_bar_display: ClickBarDisplay = chain[next_index]
	click_bar_display.cycles += cycles
	if click_bar_display.cycles > 0:
		click_bar_display.click_bar.disabled = false


func end_cycle(click_bar_index: int, cycles: int) -> void:
	if click_bar_index == 0:
		return
	var click_bar_display: ClickBarDisplay = chain[click_bar_index]
	click_bar_display.cycles -= cycles
	if click_bar_display.cycles <= 0:
		var click_bar: ClickBar = click_bar_display.click_bar
		click_bar.call_deferred("reset", true)
		click_bar.disabled = true


func _on_synchronize_click_bars() -> void:
	var min_value: float = get_smallest_click_bar_value()
	for display: ClickBarDisplay in chain:
		display.click_bar.set_value(min_value)


func get_smallest_click_bar_value() -> float:
	var min_value: float = chain[0].click_bar.get_value()
	for i: int in range(1, chain.size()):
		var click_bar: ClickBar = chain[i].click_bar
		min_value = min(min_value, click_bar.get_value())
	return min_value

func _on_level_up(level: int) -> void:
	if level >= clicks_config.size(): return
	create_chain(level)
