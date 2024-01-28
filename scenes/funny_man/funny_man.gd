extends Node2D

signal animation_finished()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#$OstrichTorso.rotation = 0
	#$OstrichTorso/OstrichHead.rotation = 0
	#$OstrichTorso/LOstrichLeg.rotation = 0
	#$OstrichTorso/ROstrichLeg.rotation = 0

func mock():
	$AnimationPlayer.play("mock")

func animation_end():
	animation_finished.emit()
