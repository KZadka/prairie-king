extends RigidBody2D


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_notifier_screen_exited() -> void:
	queue_free()
