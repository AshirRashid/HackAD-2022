extends HBoxContainer

var room_num: String


func initialize(room_num: String, append_text: String=""):
	self.room_num = room_num
	$Button.text = room_num + append_text


func _on_Button_pressed():
	get_tree().change_scene("res://Calendar.tscn")
	Globals.selected_room_num = self.room_num
