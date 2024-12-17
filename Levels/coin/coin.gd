extends AnimatedSprite2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		GameManager.coins += 1
		GameManager.score += 10
		queue_free()
		print_debug("Монетка подобрана")
