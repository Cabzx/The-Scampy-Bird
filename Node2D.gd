extends Node2D
var wall_scn = load("res://Scenes/Wall.tscn")
var bird_scn = load("res://Scenes/Bird.tscn")
var hud_scn = load("res://Scenes/HUD.tscn")
signal score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if $GameOverTimer.is_stopped() and $StartTimer.is_stopped():
		if !$AudioStreamPlayer.playing:
			$AudioStreamPlayer.play()

func _on_Timer_timeout():
	var wall = wall_scn.instance()
	add_child(wall)

func _on_Timer2_timeout():
	emit_signal("score")

func _on_Button_pressed():
	$AudioStreamPlayer.stop()
	$StartTimer.start()
	$CanvasLayer/Button.hide()
	$CanvasLayer/Sprite.hide()
	$CanvasLayer/Label.hide()
	$AudioStreamPlayer2.play()


func _on_Timer3_timeout():
	$ScoreTimer.start()
	$WallTimer.start()
	var bird = bird_scn.instance()
	var hud = hud_scn.instance()
	add_child(bird)
	add_child(hud)
	bird.connect("hit",self,"_on_Bird_hit")
	$AudioStreamPlayer.stop()

func _on_Bird_hit(health):
	if health == 0:
		$ScoreTimer.stop()
		$AudioStreamPlayer.stop()
		$GameOverTimer.start()

func game_over():
	get_tree().call_group("Walls", "queue_free")
	get_tree().call_group("Birds", "queue_free")
	get_tree().call_group("HUDs", "queue_free")
	$AudioStreamPlayer.stop()
	$WallTimer.stop()
	$CanvasLayer/Button.show()
	$CanvasLayer/Sprite.show()
	$CanvasLayer/Label.show()

func _on_GameOverTimer_timeout():
	game_over()
