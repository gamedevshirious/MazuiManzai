extends Node2D

var tsukkomi_ready = false
var bokke_ready = false
var game_start = false
var tsukkomi_action = "idle"
var bokke_action = "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()
	
func setup():
	tsukkomi_ready = false
	bokke_ready = false
	game_start = false
	
	tsukkomi_action = "idle"
	bokke_action = "idle"
	
	$straight_man/nandeyanen.visible = false
	$Stage/bokke_label.visible = false
	$Stage/tsukkomi_label.visible = true
	$Stage/tsukkomi_label.text = "tsukkomi \nReady ?"
	$Stage/bokke_label.text = "bokke \nReady ?"
	
	$Stage/tsukkomi_label/instruction.visible = true
	$Stage/bokke_label/instruction.visible = true
	
	$TimerLabel.visible = false

func _process(delta):	
	if Input.is_action_just_pressed("tsukkomi_interact"):
		tsukkomi_ready = true
		$Stage/bokke_label.visible = true
		$Stage/tsukkomi_label.text = "Ready!"
		$Stage/tsukkomi_label/instruction.visible = false
	
	if Input.is_action_just_pressed("bokke_interact"):
		bokke_ready = true
		$Stage/bokke_label.text = "Ready!"
		$Stage/bokke_label/instruction.visible = false
		
		if not game_start:
			$Director.play("play")
			game_start = true
	
	if Input.is_action_just_pressed("bokke_jump"):
		if bokke_ready and bokke_action == "idle":
			bokke_action = "jump"
	
	if Input.is_action_just_pressed("bokke_duck"):
		if bokke_ready and bokke_action == "idle":
			bokke_action = "duck"
	
	if Input.is_action_just_pressed("tsukkomi_jump"):
		if tsukkomi_ready and tsukkomi_action == "idle":
			tsukkomi_action = "jump"
	
	if Input.is_action_just_pressed("tsukkomi_duck"):
		if tsukkomi_ready and tsukkomi_action == "idle":
			tsukkomi_action = "duck"
	
func _on_timer_timeout():
	if tsukkomi_action == bokke_action and tsukkomi_action != "idle":
		$straight_man/AnimationPlayer.play("hit_" + tsukkomi_action)
		$funny_man/AnimationPlayer.play("hit_" + bokke_action)
	elif tsukkomi_action == bokke_action and tsukkomi_action == "idle":
		$straight_man/AnimationPlayer.play("shrug")
		$funny_man/AnimationPlayer.play("shrug")
	elif tsukkomi_action != "idle" and bokke_action == "idle":
		$straight_man/AnimationPlayer.play("hit_" + tsukkomi_action)
		$funny_man/AnimationPlayer.play("hit_" + tsukkomi_action)
	elif bokke_action != "idle" and tsukkomi_action == "idle":
		$straight_man/AnimationPlayer.play("shrug")
		$funny_man/AnimationPlayer.play("mock")
	else:
		$straight_man/AnimationPlayer.play("hit_" + bokke_action)
		$funny_man/AnimationPlayer.play("miss_" + tsukkomi_action)

	print("T: " + tsukkomi_action)	
	print("B: " + bokke_action)	


func _on_funny_man_animation_finished():
	setup()
