extends State

class_name HitState

@export var damageable : Damageable
@export var character_state_machine : CharacterStateMachine
@export var dead_state : State
@export var dead_animnation_node : String = "dead"
@export var knockback_speed : float = 100.0
@export var return_state : State
@export var collisionShape2D : Node



@onready var timer : Timer = $Timer

func _ready():
	damageable.connect("on_hit", on_damageable_hit)
	
func on_enter():

	timer.start()
	
	


func on_damageable_hit(node : Node, damage_amout : int, knockback_direction : Vector2):
	if(damageable.health > 0):
		character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state", self)
	else:
		collisionShape2D.set_deferred("monitoring", false)
		emit_signal("interrupt_state", dead_state)
		GameManager.score += 25
		playback.travel(dead_animnation_node)
		

func on_exit():
	character.velocity = Vector2.ZERO

func _on_timer_timeout() -> void:
	next_state = return_state
