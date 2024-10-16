extends CharacterBody2D

signal hit
var speed = 200
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down')
	velocity = direction * speed
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
