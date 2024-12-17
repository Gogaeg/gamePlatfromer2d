extends Node

class_name PlayerDamageable

signal on_player_hit(node : Node, damage_taken : int, knockback_direction : Vector2)



#Здоровье игрока
@export var health : float = 100 :
	get: 
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value
@onready var currentHealth: int = health
@export var dead_animation_name : String = "dead"
@export var hitboxPlayer : Node 




#эта функция делает так, что игрок получает урон
func hit(damage : int, knockback_direction : Vector2):
	health -= damage
	
	emit_signal("on_player_hit", get_parent(), damage, knockback_direction)



func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == dead_animation_name):
		get_parent().collision_layer &= ~3
