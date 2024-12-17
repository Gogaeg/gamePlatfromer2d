extends CharacterBody2D

class_name Player

#скорость
@export var SPEED : float = 300.0
@export var facing_shape : FacingCollisionShape2D
#стейт удара
@export var hit_state : State
#спрайт игрока
@onready var sprite : Sprite2D = $Sprite2D
#дерево анимаций
@onready var animation_tree : AnimationTree = $AnimationTree
#машина стейтов
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * SPEED
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)
	
func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
		
	emit_signal("facing_direction_changed", !sprite.flip_h)
	
