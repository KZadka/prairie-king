extends CharacterBody2D

const SPEED = 100.0
var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group('player')
	$Sprite.play()

func _process(delta: float) -> void:
	pass
	
func _on_notifier_screen_exited() -> void:
	queue_free()
	
func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * SPEED
	move_and_slide()
