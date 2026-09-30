class_name Market
extends RefCounted
## Market rules (GDD › Systems › Market): the price of grain each day, and what a trade needs.
## Pure logic with no scene tree, so tests build it directly.

var _config: MarketConfig
var _seed: int


func _init(config: MarketConfig, run_seed: int) -> void:
	_config = config
	_seed = run_seed


## The price moves up or down from the base by at most `swing`. The same seed and day always give
## the same price, whatever order days are asked in.
func price_for_day(day: int) -> int:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.seed = hash("%d:%d" % [_seed, day])
	var factor: float = 1.0 + rng.randf_range(-_config.swing, _config.swing)
	return maxi(1, roundi(_config.base_price * factor))


func can_buy(gold: int, day: int) -> bool:
	return gold >= price_for_day(day)


func can_sell(grain: int) -> bool:
	return grain > 0


func is_over(day: int) -> bool:
	return day > _config.days


func is_won(gold: int) -> bool:
	return gold >= _config.target_gold
