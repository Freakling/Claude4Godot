extends "res://tools/test_case.gd"
## Market rules (GDD › Systems › Market).

var _config: MarketConfig


func before_each() -> void:
	_config = MarketConfig.new()
	_config.starting_gold = 50
	_config.base_price = 10
	_config.swing = 0.3
	_config.days = 5
	_config.target_gold = 80


func test_price_stays_within_the_swing() -> void:
	var market: Market = Market.new(_config, 7)
	for day: int in range(1, 51):
		var price: int = market.price_for_day(day)
		expect(price >= 7 and price <= 13, "day %d costs %d" % [day, price])


func test_the_same_seed_gives_the_same_prices() -> void:
	var first: Market = Market.new(_config, 99)
	var second: Market = Market.new(_config, 99)
	for day: int in range(1, 6):
		expect_eq(second.price_for_day(day), first.price_for_day(day), "day %d" % day)


func test_prices_do_not_depend_on_the_order_days_are_asked() -> void:
	var market: Market = Market.new(_config, 3)
	var day_three: int = market.price_for_day(3)
	var _day_one: int = market.price_for_day(1)
	expect_eq(market.price_for_day(3), day_three)


func test_buying_needs_enough_gold() -> void:
	var market: Market = Market.new(_config, 1)
	var price: int = market.price_for_day(1)
	expect(market.can_buy(price, 1))
	expect_false(market.can_buy(price - 1, 1))


func test_the_run_ends_after_the_last_day() -> void:
	var market: Market = Market.new(_config, 1)
	expect_false(market.is_over(5))
	expect(market.is_over(6))


func test_the_run_is_won_at_the_target() -> void:
	var market: Market = Market.new(_config, 1)
	expect(market.is_won(80))
	expect_false(market.is_won(79))
