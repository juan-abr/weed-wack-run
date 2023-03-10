extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var mob_scene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#new_game()
	# pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	# pass # Replace with function body.

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mob", "queue_free")
	$Music.play()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	# pass # Replace with function body.


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	# pass # Replace with function body.

func _on_MobTimer_timeout():
	
	# Creates new mob scene instance
	var mob = mob_scene.instance()
	
	# Choose a random location on Path2D
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	# Set the mob's direction perpendicular to the path location
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Set the mob's direction position to a random location
	mob.position = mob_spawn_location.position
	
	# Add some randomness to the direction
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = false
	
	var velocity = Vector2(rand_range(75.0, 160.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn the mob by adding it to the main scene
	add_child(mob)
	# pass # Replace with function body.
