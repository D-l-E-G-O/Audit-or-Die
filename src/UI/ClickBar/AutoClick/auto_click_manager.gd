extends Node
class_name AutoClickManager

@export var click_bar_chain: ClickBarChain


var clickbars: Array[ClickBarDisplay] = []


func _ready() -> void:
	if !click_bar_chain:
		push_error("%s : @export var click_bar_chain is not defined." % name)
		return
	SignalBus.update_auto_clicks.connect(_on_update_auto_clicks)
	for click_bar_display in click_bar_chain.get_children():
		if click_bar_display is ClickBarDisplay:
			clickbars.append(click_bar_display)
			click_bar_display.distribution_bar.value_updated.connect(_on_distribution_bar_value_updated)


func _physics_process(delta: float) -> void:
	for click_bar_display: ClickBarDisplay in clickbars:
		if click_bar_display.cps < 0:
			push_error("%s : ClickBarDisplay %s isn't registered in the dictionnary" % [name, click_bar_display.name])
			clickbars.erase(click_bar_display)
		elif !click_bar_display.click_bar.disabled:
			click_bar_display.click_bar.add_value(click_bar_display.cps * delta)


func _on_update_auto_clicks(value: float) -> void:
	if get_distribution_percentage_remainder(-1) == 100.0:
		clickbars[0].distribution_bar.value = 100.0
		_on_distribution_bar_value_updated(clickbars[0].distribution_bar)
	else:
		update_all_cps()


func _on_distribution_bar_value_updated(bar: DistributionBar) -> void:
	var max_value: float = get_distribution_percentage_remainder(bar.get_instance_id())
	bar.value = clampf(bar.value, 0.0, max_value)
	update_cps(bar.get_instance_id(), bar.value)


func get_distribution_percentage_remainder(bar_id: int) -> float:
	var total_remainder: float = 100
	for click_bar_display: ClickBarDisplay in clickbars:
		var distribution_bar: DistributionBar = click_bar_display.distribution_bar
		if distribution_bar.get_instance_id() != bar_id:
			total_remainder -= distribution_bar.value
	return total_remainder


func update_cps(bar_id: int, value: float) -> void:
	var n: int = clickbars.size()
	var i: int = 0
	var found: bool = false
	while i<n && !found:
		var click_bar_display: ClickBarDisplay = clickbars[i]
		var distribution_bar: DistributionBar = click_bar_display.distribution_bar
		if distribution_bar.get_instance_id() == bar_id:
			click_bar_display.cps = Global.get_auto_clicks() * (value / 100)
			found = true
		else:
			i += 1
	if !found:
		push_error("%s : The ClickBarDisplay wasn't found" % name)


func update_all_cps() -> void:
	for click_bar_display: ClickBarDisplay in clickbars:
		var value: float = click_bar_display.distribution_bar.value
		click_bar_display.cps = Global.get_auto_clicks() * (value / 100)
