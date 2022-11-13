extends HBoxContainer

onready var Request: HTTPRequest = $HTTPRequest

var time: String


func initialize(time: String, available=true):
	"""Example value for TIME: 8 am
	"""
	self.time = time
	$Label.text = time
	if !available:
		$Button.text = "Booked"


func _on_Button_pressed():
	var body
	if $Button.text == "Booked":
		body = to_json({"RoomNum": Globals.selected_room_num, "StartTime": self.time, "NetID": "abc123", "Cancel": true})
	else:
		body = to_json({"RoomNum": Globals.selected_room_num, "StartTime": self.time, "NetID": "abc123", "Cancel": false})
		
	var error = Request.request("http://localhost:5000/creating", [], false, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error("An error occurred in the HTTP request.")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var isBookingSuccessful: bool = parse_json(body.get_string_from_utf8())["Successful"]
	if isBookingSuccessful:
		$Button.text = "Booked" if $Button.text == "" else ""
