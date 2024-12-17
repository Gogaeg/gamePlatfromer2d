extends Label


@export var statemachine : CharacterStateMachine



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "State : " + statemachine.current_state.name
