extends CharacterBody2D


const SPEED = 200.0
var screen_size
var attacking = false

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func _physics_process(delta: float) -> void:

	velocity = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down') * SPEED
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

	if not attacking:
		if velocity.length() > 0:
			$AnimatedSprite2D.play('walk')
		else:
			$AnimatedSprite2D.play('idle')
	if Input.is_action_just_pressed('attack'):
		attacking = true
		if velocity.y < 0:
			$AnimatedSprite2D.play('up_attack')
		elif velocity.y > 0:
			$AnimatedSprite2D.play('down_attack')
		else:
			$AnimatedSprite2D.play('side_attack')
		if not $AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.animation_finished.emit()

	move_and_slide()
	position = position.clamp(Vector2.ZERO, screen_size)

func start(pos):
	position = pos
	$CollisionShape2D.disabled = false

func _on_body_entered(body: Node2D) -> void:
	pass
	#print('HIT!!!')
	#hide()
	#hit.emit()
	#$CollisionShape2D.set_deferred('disabled', true)
	#show()


func _on_animated_sprite_2d_animation_finished() -> void:
	attacking = false	
