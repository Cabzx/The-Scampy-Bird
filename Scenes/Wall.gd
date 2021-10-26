extends Node2D

func _process(delta):
	position.x-=100*delta

func _ready():
	position.x=50
	position.y=clamp((randi() % 840) - 200,-200,640)


func _on_Timer_timeout():
	queue_free()
