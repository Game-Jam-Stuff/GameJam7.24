class_name Door
extends Portal2D

@export var anim_player : AnimationPlayer
@export var levelNum : int
@export var ExitLevel : bool
@export var locked : bool = true

signal player_entered



func _on_interacted():
	if !locked:
		var currentLevel : int = GameLevelLog.get_current_level()
		var maxLevel =  GameLevelLog.get_max_level()
		var maxLevelReached = GameLevelLog.get_max_level_reached()
		print(maxLevelReached >= levelNum)
		if ExitLevel:
			if currentLevel == levelNum:
				currentLevel += 1
				GameLevelLog.level_reached(currentLevel)
			if currentLevel == maxLevel:
				next_scene_path = "res://Menu_and_UI/scenes/WinScreen/WinScreen.tscn"
			
			anim_player.play("Can_Teleport")
		elif maxLevelReached >= levelNum:
			anim_player.play("Can_Teleport")
	



func _on_animation_player_animation_finished(anim_name):
	player_entered.emit()


func _on_player_entered() -> void:
	pass # Replace with function body.
