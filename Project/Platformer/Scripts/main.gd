extends Node

# Background image by <a href="https://www.freepik.com/free-vector/flat-design-pixel-art-cloud-illustration_38680485.htm#query=pixel%20art%20sky&position=3&from_view=keyword&track=ais_user&uuid=4687914e-b158-40d1-9a44-7d21307d2b8d">Freepik</a>
# Sounds by www.kenney.nl
# Fonts by www.kenney.nl
# Music by Ruggia Matias

@onready var camera = $Robot/Camera2D
@onready var tile_map : TileMap = $TileMap
@export var platform_scene : PackedScene
var score
# Array for storing the platforms when spawning.
var platforms : Array
# Making the screen size an integer.
var screen_size : Vector2i
const PLATFORM_DELAY : int = 1
# PLatforms only spawn in the width of the screen.
const PLATFORM_RANGE : int = 480
# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenu.connect("start", new_game)
	$HUD.hide()
	$Robot.hide()
func new_game():
	$Robot.show()
	$BackgroundMusic.play()
	# Clear all platforms.
	platforms.clear()
	# Generate starting platforms.
	spawn_platform()
	# Clear score.
	score = 0
	$StartTimer.start()
	$IslandTimer.start()
	$HUD.show()
	
func game_over():
	$BackgroundMusic.stop()
	$PlatformTimer.stop()
	$ScoreTimer.stop()
	$StartTimer.stop()
	$MainMenu.show()
	$MainMenu/TextureRect/GridContainer/PlayButton.hide()
	$MainMenu/TextureRect/GridContainer/TextureRect/TextLabel.text = "score: " + str(score)
func _on_score_timer_timeout():
	score += 1
	update_score()
func update_score():
	$HUD/ScoreRect/ScoreLabel.text = "SCORE: " + str(score)
	
func _on_start_timer_timeout():
	$PlatformTimer.start()
	$ScoreTimer.start()
	
func _on_platform_timer_timeout():
	spawn_platform()
	
func spawn_platform():
	var platform = platform_scene.instantiate()
	platform.position.y = camera.get_screen_center_position().y + PLATFORM_DELAY - 400
	platform.position.x = (screen_size.x)/ 2 + randi_range(0, PLATFORM_RANGE)
	add_child(platform) # Create platform.
	platforms.append(platform) # Add new platform to the Array.


func _on_island_timer_timeout():
	tile_map.position.y = 800 # "Removes" starting island in 15 seconds.


func _on_fall_dead_dead():
	game_over()
