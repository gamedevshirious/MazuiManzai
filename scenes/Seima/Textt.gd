extends TextEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	# テキストを設定
	text = "Mazui Manzai"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_text_entered(new_text):
	# TextEnteredシグナルで新しいテキストが入力されたときに呼ばれるメソッド
	# 入力されたテキストを元に戻す（変更を無視する）
	text = "Mazui Manzai"
	set_text(text)
