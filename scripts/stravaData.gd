extends HTTPRequest

func _ready ():
	# I've been told this makes the game faster by avoiding to load the main game thread.
	self.set_use_threads(true)
	
	# Using another URL will allow to reach for another part of the endpoint
	# var url = "https://www.strava.com/api/v3/athlete"
	var baseActivityUrl = "https://www.strava.com/api/v3/athlete/activities"
	var startDate = "1717203661"
	var endDate = "1727806370"
	var url = baseActivityUrl + "?before=" + startDate + "&after=" + endDate
	
	# Replace ABCDEF by the "Request token" available here: https://www.strava.com/settings/api
	var headers = ["Authorization: Bearer ABCDEF"]
	
	self.request(url, headers, HTTPClient.METHOD_GET)
	self.request_completed.connect(_on_request_completed)
	print("URL : " + str(url))

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result == 0 and response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		print("result = " + str(result) + ", response_code = " + str(response_code) + ".")
		print(json)
	else:
		var json = JSON.parse_string(body.get_string_from_utf8())
		print("Connection issue, result = " + str(result) + ", response_code = " + str(response_code) + ". Code 401 is Unauthorized, most likely forgot to update the Strave token.")
		print(json)
