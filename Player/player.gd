extends CharacterBody2D

signal hit
var speed = 200
var screen_size
var attacks = ['side_attack', 'up_attack', 'down_attack']

@onready var state_machine = $AnimationTree['parameters/playback']

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	var  current_anim = state_machine.get_current_node()
	velocity = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down') * speed
	
	if velocity.x != 0:
		$Sprite2D.x = sign(velocity.x)
	
	if velocity.length() > 0:
		state_machine.travel('walk')
	else:
		state_machine.travel('idle')
	move_and_slide()
	position = position.clamp(Vector2.ZERO, screen_size)
	
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$Collision.set_deferred('disabled', true)
	show()
	
func start(pos):
	position = pos
	$Collision.disabled = false
