extends RigidBody2D

var _position_last_frame := Vector2()
var _cardinal_direction = 0
var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group('player')
	$Sprite.play()

func _process(delta: float) -> void:
	pass
	
func _on_notifier_screen_exited() -> void:
	queue_free()
	
func _physics_process(delta: float) -> void:
	$Sprite.rotation_degrees = 0
	var motion = position - _position_last_frame
	if motion.length() > 0.0001:
		_cardinal_direction = int(4.0 * (motion.rotated(PI / 4.0).angle() + PI) / TAU)
		
	match _cardinal_direction:
		0:
			$Sprite.flip_v = true
		1:
			$Sprite.rotation_degrees = 90.0
		3:
			$Sprite.rotation_degrees = 270.0
	position += (player.global_position - global_position) / 200
	_position_last_frame = position
