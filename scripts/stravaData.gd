extends HTTPRequest

func _ready ():
	# I've been told this makes the game faster by avoiding to load the main game thread.
	self.set_use_threads(true)
	
	
	# ------------ Test Get "Code" with read_all authorization -------------------------
	# See step-by-step "for demo purposes" here: https://developers.strava.com/docs/getting-started/#oauth
	# Code obtained is only valid once, and the URL below works (confirmed 200 + string received). WARNING: it must be a POST request, not a GET !
	# var startUrl = "https://www.strava.com/oauth/token"
	# var client_id = TBD (found here: https://www.strava.com/settings/api)
	# var client_secret= TBD (found here: https://www.strava.com/settings/api)
	# var code= TBD (see https://developers.strava.com/docs/getting-started/#oauth)
	# var grant_type="authorization_code" # DO NOT MODIFY THIS ONE
	# var url = startUrl + "?client_id=" + client_id + "&client_secret=" + client_secret + "&code=" + code + "&grant_type=" + grant_type
	# ----------------------------------------------------------------------------------
	
	# Code below does not seem to find the ID..
	# var baseActivityUrl = "https://www.strava.com/api/v3/activities/"
	# var activityTestID = "12171600135"
	# var url = baseActivityUrl + activityTestID + "?include_all_efforts=false"
	
	# variables to try and read all activites between two epoch timestamp. Does not work due to scope being too small
	# var baseActivityUrl = "https://www.strava.com/api/v3/athlete/activities"
	# var startDate = "1717203661"
	# var endDate = "1727806370"
	# var authorization = "read_all"
	# var url = baseActivityUrl + "?before=" + startDate + "&after=" + endDate + "&scope=activity:" + authorization
	
	# ----------- BASIC API CALL TO GET ATHLETE -----------------------
	# Replace YOURACCESSTOKEN by the "Request token" available here: https://www.strava.com/settings/api
	var url = "https://www.strava.com/api/v3/athlete"
	var headers = ["Authorization: Bearer YOURACCESSTOKEN"]
	# -----------------------------------------------------------------
	
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
