extends Control

onready var Request: HTTPRequest = $HTTPRequest
onready var CalendarUnitsParent: Control = $V/SC/Calendar

var CalendarUnitPreload = preload("res://CalendarUnit.tscn")
var CalendarTimes: Array = [
	"8 am",
	"9 am",
	"10 am",
	"11 am",
	"12 pm",
	"1 pm",
	"2 pm",
	"3 pm",
	"4 pm",
	"5 pm",
	"6 pm",
	"7 pm",
	"8 pm",
	"9 pm",
	"10 pm",
	"11 pm",
]


func _ready():
	var body = to_json({"RoomNum": Globals.selected_room_num})
	var error = Request.request("http://localhost:5000/viewing", [], false, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error("An error occurred in the HTTP request.")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	body = parse_json(body.get_string_from_utf8())
	if result == 0:
		show_calendar(body["BookingTimeArr"])


func show_calendar(UnavailableTimes):
	for time in CalendarTimes:
		var CalendarUnit = CalendarUnitPreload.instance()
		if time in UnavailableTimes:
			CalendarUnit.initialize(time, false)
		else:
			CalendarUnit.initialize(time)
		CalendarUnitsParent.add_child(CalendarUnit)


func _on_Back_pressed():
	get_tree().change_scene("res://Main.tscn")
