class_name GameLog
extends Node
## Logs total count of games started through [Config].

const GAME_LOG_SECTION = "GameLog"
const TOTAL_GAMES_STARTED = "TotalGamesStarted"
const IN_BEGINNING = "InBeginning"

static func game_started() -> void:
	var total_games_started = Config.get_config(GAME_LOG_SECTION, TOTAL_GAMES_STARTED, 0)
	total_games_started += 1
	Config.set_config(GAME_LOG_SECTION, TOTAL_GAMES_STARTED, total_games_started)


static func get_in_beginning():
	var begin = Config.get_config(GAME_LOG_SECTION, IN_BEGINNING, 0)
	return begin

static func set_in_beginning(begin : bool):
	Config.set_config(GAME_LOG_SECTION, IN_BEGINNING, begin)
	
