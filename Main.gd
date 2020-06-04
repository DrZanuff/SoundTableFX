extends Node

var file_button = load("res://SoundButton/SoundFile.tscn")
var project_path
var audio_path
onready var itens = $Main/Window/Left/Files/Body/Scroll/Itens
onready var list = $Main/Window/Right/M/Body/List/M/Menu/MenuButton

func _ready() -> void:
	list.get_popup().connect("id_pressed",self,"id_select")
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
					new_file_button.get_node("Body/Add/Button").connect("pressed",self,"add_to_list",[new_file_button.get_path(),file_name])
			file_name = dir.get_next()

func add_to_list( path , file ):
	
	pass

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


func _on_Add_pressed() -> void:
	$SaveList.show()
#	list.get_popup().add_item("New Item")
#	var last = list.get_popup().get_item_count()-1
#	list.text = list.get_popup().get_item_text(last)

func _on_ListNameField_text_changed(new_text: String) -> void:
	if new_text != "":
		$SaveList/OuterM/InnerM/M/Box/ButtonSaveList.disabled = false
	else:
		$SaveList/OuterM/InnerM/M/Box/ButtonSaveList.disabled = true

func _on_ButtonSaveList_pressed() -> void:
	var text = $SaveList/OuterM/InnerM/M/Box/ListNameField.text
	for t in range(list.get_popup().get_item_count() ):
		if list.get_popup().get_item_text(t) == text:
			$SaveList/OuterM/InnerM/M/Box/ListNameField.text = ""
			$SaveList/OuterM/InnerM/M/Box/ListNameField.placeholder_text = "Name already exists"
			return
	
	list.get_popup().add_item(text)
	list.text = text
	$SaveList.hide()
	$SaveList/OuterM/InnerM/M/Box/ListNameField.text = ""
	$SaveList/OuterM/InnerM/M/Box/ListNameField.placeholder_text = "Type List Name"
	$Main/Window/Right/M/Body/List/M/Menu/Edit.disabled = false
	$Main/Window/Right/M/Body/List/M/Menu/Remove.disabled = false
	$Main/Window/Right/M/Body/List/M/Menu/Save.disabled = false
	
func id_select(id):
	list.text = list.get_popup().get_item_text(id)
