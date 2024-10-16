extends Node

@export var mob_scene: PackedScene
var score
var spawn_list

func _ready() -> void:
	spawn_list = [$MobSpawn1, $MobSpawn2, $MobSpawn3, $MobSpawn4]
	new_game()

func _process(delta: float) -> void:
	pass


func _on_player_hit() -> void:
	pass
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var mob_spawn_location = spawn_list[randi_range(0, 3)]
	var direction = mob_spawn_location.rotation
	mob.position = mob_spawn_location.position
	var velocity = Vector2(randf_range(50.0, 100.0), 0.0)
	mob.rotation = direction
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
