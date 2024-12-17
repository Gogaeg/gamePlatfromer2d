extends Node

#задает колво монеток и счета
var coins = 0
var score = 0

func _process(delta: float) -> void:
	$"ScoreCoinGUI/CoinsValue".text = str(coins)
	$"ScoreCoinGUI/ScoreValue".text = str(score)
