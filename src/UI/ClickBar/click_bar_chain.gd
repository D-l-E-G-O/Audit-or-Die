extends HBoxContainer
class_name ClickBarChain


var chain: Array[ClickBar] = []
var cycles_list: Array[int] = []
var identifiers: Array[int] = []
var debug_sources: Array[DebugComponent] = []


func _ready() -> void:
	create_chain()
	create_cycles_list()
	get_identifiers()
	link_click_bars()
	create_debug_panels()


func create_chain() -> void:
	for click_bar: ClickBar in get_children():
		click_bar.disabled = true
		chain.append(click_bar)
	chain[0].disabled = false


func create_cycles_list() -> void:
	for i: int in range(0, chain.size()):
		cycles_list.append(0)


func get_identifiers() -> void:
	for i: int in range(0, chain.size()):
		identifiers.append(chain[i].get_instance_id())


func link_click_bars() -> void:
	var n: int = chain.size()
	for i: int in range(0, n):
		chain[i].cycle_completed.connect(_on_cycle_completed)


func create_debug_panels() -> void:
	var n: int = chain.size()
	for i: int in range(1, n):
		var cycles_debug := DebugComponent.new()
		cycles_debug.get_debug_values_callable = func() -> Array[DebugValue]:
			return [
				DebugValue.new("Clicks required", func() -> int: return chain[i].required_clicks),
				DebugValue.new("Cycles", func() -> int: return cycles_list[i])
			]
		cycles_debug.attach_debug_panel(chain[i], chain[i].size.y)
		debug_sources.append(cycles_debug)


func _on_cycle_completed(id: int, cycles: int) -> void:
	var click_bar_index: int = identifiers.find(id)
	if click_bar_index == -1:
		push_error("Click Bar not found")
		return
	if click_bar_index < chain.size() - 1:
		add_cycle(click_bar_index + 1, cycles)
	else:
		print("Completed %d cycles !" % cycles)
	end_cycle(click_bar_index)


func add_cycle(next_index: int, cycles: int) -> void:
	cycles_list[next_index] += cycles
	if cycles_list[next_index] > 0:
		chain[next_index].disabled = false
	debug_sources[next_index-1].notify_debug_update()


func end_cycle(click_bar_index: int) -> void:
	if click_bar_index == 0:
		return
	cycles_list[click_bar_index] -= 1
	if cycles_list[click_bar_index] <= 0:
		chain[click_bar_index].disabled = true
	debug_sources[click_bar_index-1].notify_debug_update()
