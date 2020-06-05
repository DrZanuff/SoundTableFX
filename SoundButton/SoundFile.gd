extends MarginContainer

var sound_file = ""
var sound_name = ""

var play_icon = "res://icons/TransitionImmediateAutoBig.svg"
var stop_icon = "res://icons/Pause.svg"
var playing = false

func set_path(path : String):
	sound_file = path

func get_path():
	return sound_file

func set_name(name : String):
	sound_name = name
	$Body/Label.text = name

func get_name():
	return sound_name
	
func set_status(status : bool):
	playing = status
	if status:
		$Body/Play/Button.icon = load(play_icon)
	else:
		$Body/Play/Button.icon = load(stop_icon)

func get_status():
	return playing

func disable_add_button(status):
	$Body/Add/Button.disabled = status



#var sel = false
#var colors = [
#	Color(0.588235, 0.588235, 0.588235, 0.298039) ,
#	Color(0.129412, 0.313726, 0.870588, 0.270588) 
#	]
#
#func _ready() -> void:
#	$Button.connect( "pressed" , self , "select" ) 
#
#
#func select():
#	sel = !sel
#	if sel:
#		print( $Panel.get("custom_styles/panel") )
#		$Panel.get("custom_styles/panel").bg_color = colors[1]
#
#	else:
#		$Panel.get("custom_styles/panel").bg_color = colors[0]
#		print( $Panel.get("custom_styles/panel") )
