extends HBoxContainer
class_name ClickBarChain


var chain: Array[ClickBarDisplay] = []
var identifiers: Array[int] = []


func _ready() -> void:
	SignalBus.synchronize_click_bars.connect(_on_synchronize_click_bars)
	create_chain()
	get_identifiers()
	link_click_bars()


func create_chain() -> void:
	for click_bar_display in get_children():
		if click_bar_display is ClickBarDisplay:
			click_bar_display.click_bar.disabled = true
			chain.append(click_bar_display)
	chain[0].click_bar.disabled = false


func get_identifiers() -> void:
	for display: ClickBarDisplay in chain:
		identifiers.append(display.click_bar.get_instance_id())


func link_click_bars() -> void:
	for display: ClickBarDisplay in chain:
		var click_bar: ClickBar = display.click_bar
		click_bar.cycle_completed.connect(_on_cycle_completed)


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
