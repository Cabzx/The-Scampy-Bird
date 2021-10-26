extends CanvasLayer
var score
var HP

# Called when the node enters the scene tree for the first time.
func _ready():
	var is_hit = get_tree().get_root().find_node("Bird",true,false)
	var score_timer = get_tree().get_root().find_node("World",true,false)
	
	score_timer.connect("score",self,"_on_Timer2_signal")
	is_hit.connect("hit",self,"_on_Bird_hit")
	
	$AnimatedSprite.set_frame(0)
	$AnimatedSprite2.set_frame(0)
	$AnimatedSprite3.set_frame(0)
	score = 0
	

func _on_Timer2_signal():
	score+=1
	$Label.text = str(score)

func _on_Bird_hit(health):
	$AnimatedSprite.set_frame(12-int(health))
	$AnimatedSprite2.set_frame(8-int(health))
	$AnimatedSprite3.set_frame(4-int(health))
	
	
func _process(delta):
	pass
