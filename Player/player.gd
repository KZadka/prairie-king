extends Area2D

signal hit
var speed = 200
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$Sprite.play()

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed('move_up'):
		velocity.y -= 1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
	if Input.is_action_pressed('move_left'):
		velocity.x -= 1
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	if velocity.x != 0:
		$Sprite.flip_h = velocity.x < 0
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$Collision.set_deferred('disabled', true)
	show()
	
func start(pos):
	position = pos
	$Collision.disabled = false
