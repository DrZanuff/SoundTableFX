extends Node

var file_button = load("res://SoundButton/SoundFile.tscn")
var project_path
var audio_path
onready var itens = $Main/Window/Left/Files/Body/Scroll/Itens

func _ready() -> void:
	project_path = ProjectSettings.globalize_path("res://")
	audio_path = project_path + "Audios/"
	
	var dir = Directory.new()
	if dir.open(audio_path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				if str(file_name).find(".import") == -1:
					var new_file_button = file_button.instance()
					itens.add_child(new_file_button)
					new_file_button.set_path(audio_path+file_name)
					new_file_button.set_name(file_name)
					new_file_button.get_node("Body/Play/Button").connect("pressed",self,"play_audio",[new_file_button.get_path(),new_file_button])
			file_name = dir.get_next()

func play_audio(path , button):
	button.set_status(false)
	$Player.stop()
	var audio = AudioStreamOGGVorbis.new()
	var file = File.new()
	if file.file_exists(path):
		file.open( path , File.READ )
		var l = file.get_len()
		var bytes = file.get_buffer(l)
		audio.data = bytes
		$Player.stream = audio
		$Player.play()
		file.close()
	else:
		printt("no" , path)
		
func _on_Player_finished() -> void:
	get_tree().call_group("Button","set_status",true)
