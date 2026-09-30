class_name MarketConfig
extends Resource
## Tunable market values (GDD › Systems › Market). The human tunes them in data/market_config.tres.

@export var starting_gold: int = 50 ## PLACEHOLDER
@export var base_price: int = 10 ## PLACEHOLDER
## How far the price moves from the base, as a fraction: 0.3 means ±30 %.
@export_range(0.0, 1.0) var swing: float = 0.3 ## PLACEHOLDER
@export var days: int = 5
@export var target_gold: int = 80 ## PLACEHOLDER
