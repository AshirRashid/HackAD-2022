extends MarginContainer

onready var Request: HTTPRequest = $HTTPRequest

var RoomHBoxPreload = preload("res://Main_RoomHbox.tscn")
var RoomNumArr = [
	"Room 1",
	"Room 2",
	"Room 3",
	"Room 4",
	"Room 5",
]

func _ready():
	var body = to_json({"NetID": "abc123"})
	var error = Request.request("http://localhost:5000/overview", [], false, HTTPClient.METHOD_GET, body)
	if error != OK:
		push_error("An error occurred in the HTTP request.")

func show_room_nums(RoomNumsWithBookings: Array):
	for RoomNum in RoomNumArr:
		var RoomHBox = RoomHBoxPreload.instance()
		if RoomNum in RoomNumsWithBookings:
			RoomHBox.initialize(RoomNum, " (Your Booking)")
		else:
			RoomHBox.initialize(RoomNum)
		$V/V.add_child(RoomHBox)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	body = parse_json(body.get_string_from_utf8())
	if result == 0:
		show_room_nums(body["RoomNumsWithSelfBookings"])
		$V/H/AvailableBookings.text = "You have " + str(body["BookingsLeft"]) + " booking(s) left."
