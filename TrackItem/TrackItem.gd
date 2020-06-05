extends MarginContainer

var play_icon = "res://icons/TransitionImmediateAutoBig.svg"
var stop_icon = "res://icons/Pause.svg"
var playing = false

func set_status(status : bool):
	playing = status
	if status:
		$Body/Play/Button.icon = load(play_icon)
	else:
		$Body/Play/Button.icon = load(stop_icon)

func set_name(file):
	$Body/Label.text = file
