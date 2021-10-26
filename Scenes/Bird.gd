extends Area2D
export (int) var Vel
export (float) var giro
signal hit(HP)
var HP

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x=0
	position.y=50
	HP = 12

func _process(delta):
	position.y += delta*Vel
	if not $AudioStreamPlayer.is_playing():
		if not $AnimatedSprite.is_playing():
			fly()
		if rotation<0:
			rotation=0
		if rotation!=0:
			rotation-=0.02
	else :
		$AnimatedSprite.play("Hit")
	if (position.y < -50 or position.y > 670) and HP > 0:  
		kill()

func _input(_event):
	if not $AudioStreamPlayer.is_playing():
		if Input.is_action_just_pressed("ui_up"):
			jump()
		if Input.is_action_just_pressed("ui_down"):
			duck()

func jump():
	position.y-=0.8*Vel
	$AnimatedSprite.play("Jump")
	$AudioStreamPlayer2D2.play()
	giro = 0.25-rotation
	rotate(giro)

func duck():
	position.y+=0.4*Vel
	$AnimatedSprite.play("Jump")
	$AudioStreamPlayer2D2.play()
	giro = 0.25-rotation
	rotate(giro)

func fly():
	$AnimatedSprite.play("Fly")

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()

func _on_Bird_area_entered(_area):
	hit()

func hit():
	HP -= 1
	emit_signal("hit",clamp(HP,0,12))
	$AnimatedSprite.play("Hit")
	$AudioStreamPlayer2D.play()
	if HP == 0:
		kill()

func kill():
	HP = 0
	emit_signal("hit",HP)
	$CollisionShape2D2.set_deferred("disabled",true)
	$AudioStreamPlayer.play()
