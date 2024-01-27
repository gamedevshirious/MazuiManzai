extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$straight_man/nandeyanen.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$straight_man/AnimationPlayer.play("hit")
		$funny_man/AnimationPlayer.play("hit")

