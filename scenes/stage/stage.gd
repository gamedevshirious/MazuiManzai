extends Node2D

var tsukkomi_ready = false
var bokke_ready = false
var game_start = false
var tsukkomi_action = "idle"
var bokke_action = "idle"

var json_as_dict
var key

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = "res://data/jokes.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	json_as_dict = JSON.parse_string(json_as_text)
	
	setup()
	
func setup():
	tsukkomi_ready = false
	bokke_ready = false
	game_start = false
	
	tsukkomi_action = "idle"
	bokke_action = "idle"
	
	$straight_man/nandeyanen.visible = false
	$Stage/bokke_label.visible = true
	$Stage/tsukkomi_label.visible = false
	$Stage/tsukkomi_label.text = "tsukkomi \nReady ?"
	$Stage/bokke_label.text = "bokke \nReady ?"
	
	$Stage/tsukkomi_label/instruction.visible = true
	$Stage/bokke_label/instruction.visible = true
	
	$TimerLabel.visible = false
	
	var size = json_as_dict.size()
	key = json_as_dict.keys()[randi() % size]	
	
	print(key)

func _process(_delta):	
	if Input.is_action_just_pressed("tsukkomi_interact"):
		tsukkomi_ready = true
		$Stage/tsukkomi_label.text = "Ready!"
		$Stage/tsukkomi_label/instruction.visible = false
		if not game_start:
			$Director.play("play")
			game_start = true
	
	
	if Input.is_action_just_pressed("bokke_interact"):
		bokke_ready = true
		$Stage/tsukkomi_label.visible = true
		$Stage/bokke_label.text = "Ready!"
		$Stage/bokke_label/instruction.visible = false
		
		$Director.play("bokke_dialog")
		
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
		$Director.play("tsukkomi_dialog")
	elif tsukkomi_action == bokke_action and tsukkomi_action == "idle":
		$straight_man/AnimationPlayer.play("shrug")
		$Director.play("tsukkomi_dialog")
		#setup()
	elif tsukkomi_action != "idle" and bokke_action == "idle":
		$straight_man/AnimationPlayer.play("hit_" + tsukkomi_action)
		$funny_man/AnimationPlayer.play("hit_" + tsukkomi_action)
		$Director.play("tsukkomi_dialog")
	elif bokke_action != "idle" and tsukkomi_action == "idle":
		$straight_man/AnimationPlayer.play("shrug")
		$funny_man/AnimationPlayer.play("mock")
	else:
		$straight_man/AnimationPlayer.play("hit_" + tsukkomi_action)
		$funny_man/AnimationPlayer.play("miss_" + bokke_action)

func start_game():
	$Director.play_backwards("bokke_dialog")

func _on_funny_man_animation_finished():	
	setup()

func get_tsukkomi_dialog():
	if tsukkomi_action != "idle":
		$"dailog-box/label".text = json_as_dict[key]["S"]
	else:
		$"dailog-box/label".text = "Player1: Wキー　ジャンプ or Sキー　しゃがむ\nPlayer2: ↑upキー　上を叩く or ↓Dnキー　下を叩く\n当たるかかわすかで勝負！"

func get_bokke_dialog():
	$"dailog-box/label".text = json_as_dict[key]["F"]
