extends MarginContainer

var play_icon = "res://icons/TransitionImmediateAutoBig.svg"
var stop_icon = "res://icons/Pause.svg"
var playing = false
signal set_new_key

func set_status(status : bool):
	playing = status
	if status:
		$Body/Play/Button.icon = load(play_icon)
	else:
		$Body/Play/Button.icon = load(stop_icon)

func set_name(file):
	$Body/Label.text = file

func set_key():
	$Body/ShotCut/LineEdit.placeholder_text = "Press Key or Esc"
	emit_signal("set_new_key")

func set_text(t):
	$Body/ShotCut/LineEdit.placeholder_text = t
	$Body/ShotCut/LineEdit.release_focus()

func get_label_text():
	return $Body/Label.text
