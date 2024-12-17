extends State

class_name PlayerHitState

@export var damageble : PlayerDamageable
@export var character_state_machine : CharacterStateMachine
@export var dead_state : State
@export var dead_animation_node : String = "dead"
@export var knockback_speed : float = 100.0
@export var return_state : State

@onready var timer : Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	damageble.connect("on_player_hit", on_player_damageable_hit)
	
func on_enter():

	timer.start()
	
	
func on_player_damageable_hit(node : Node, damage_amount : int, knockback_direction : Vector2):
	if(damageble.health > 0):
		character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state", self)
	else:
		GameManager.coins = 0
		GameManager.score = 0
		emit_signal("interrupt_state", dead_state)
		print("Игрок перешел в state Dead")
		playback.travel(dead_animation_node)
		
func on_exit():
	character.velocity = Vector2.ZERO


func _on_timer_timeout() -> void:
	next_state = return_state
