extends Node
## The current run (GDD › Core Loop): day, gold and grain. It holds the state, applies Market's
## rules and emits `changed`. Screens read it and call its methods.

signal changed

const CONFIG_PATH: String = "res://data/market_config.tres"

var day: int = 1
var gold: int = 0
var grain: int = 0

var _market: Market


func _ready() -> void:
	start_run(randi())


func start_run(run_seed: int) -> void:
	var config: MarketConfig = load(CONFIG_PATH) as MarketConfig
	_market = Market.new(config, run_seed)
	day = 1
	gold = config.starting_gold
	grain = 0
	changed.emit()


func price() -> int:
	return _market.price_for_day(day)


func can_buy() -> bool:
	return not is_over() and _market.can_buy(gold, day)


func buy() -> bool:
	if not can_buy():
		return false
	gold -= price()
	grain += 1
	changed.emit()
	return true


func sell() -> bool:
	if is_over() or not _market.can_sell(grain):
		return false
	gold += price()
	grain -= 1
	changed.emit()
	return true


func next_day() -> void:
	if is_over():
		return
	day += 1
	changed.emit()


func is_over() -> bool:
	return _market.is_over(day)


func is_won() -> bool:
	return _market.is_won(gold)
