extends Control


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	Engine.time_scale = 1
	GameManager.coins = 0
	GameManager.score = 0
