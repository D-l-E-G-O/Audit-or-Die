extends HBoxContainer
class_name ClickBarChain


var chain: Array[ClickBar] = []
var cycles_list: Array[int] = []
var identifiers: Array[int] = []


func _ready() -> void:
	create_chain()
	create_cycles_list()
	get_identifiers()
	link_click_bars()


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
	#print("Index : %d, cycles : %d" % [next_index, cycles_list[next_index]])


func end_cycle(click_bar_index: int) -> void:
	if click_bar_index == 0:
		return
	cycles_list[click_bar_index] -= 1
	if cycles_list[click_bar_index] <= 0:
		chain[click_bar_index].disabled = true
	#print("Index : %d, cycles : %d" % [click_bar_index, cycles_list[click_bar_index]])
