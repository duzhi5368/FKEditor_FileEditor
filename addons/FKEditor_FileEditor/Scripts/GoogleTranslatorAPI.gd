# Created by Freeknight
# Date: 2021/12/13
# Desc：Google翻译接口
# @category: 辅助类
#--------------------------------------------------------------------------------------------------
tool
extends HTTPRequest
class_name GoogleTranslateAPI
### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------
signal translation_received(translations)
#--- enums ----------------------------------------------------------------------------------------
#--- constants ------------------------------------------------------------------------------------
#--- public variables - order: export > normal var > onready --------------------------------------
var endpoint : String = "https://translation.googleapis.com/language/translate/v2"
var headers : PoolStringArray = ["Authorization: Bearer [token]", "Content-Type: application/json; charset=utf-8"]
var token : String = ""
#--- private variables - order: export > normal var > onready -------------------------------------
### -----------------------------------------------------------------------------------------------

### Built in Engine Methods -----------------------------------------------------------------------
func _ready() -> void:
	connect("request_completed", self, "_on_translation_received")
### -----------------------------------------------------------------------------------------------

### Public Methods --------------------------------------------------------------------------------
func set_token(t : String) -> void:
	token = t
# ------------------------------------------------------------------------------
func get_token() -> String:
	return token
# ------------------------------------------------------------------------------
# func request_dummy() -> void:
# 	var dummy : Dictionary = { "source":"en", "target": "ru", "q": ["Dr. Watson, come here!", "Bring me some coffee!"] }
#	request_translation(dummy.source, dummy.target, dummy.q)

func request_translation(source_language : String, target_language : String, contents : PoolStringArray) -> void:
	var temp_headers : PoolStringArray = headers
	temp_headers[0] = temp_headers[0].replace("[token]", token)
	request(endpoint, temp_headers, true, HTTPClient.METHOD_POST, \
		JSON.print({"source":source_language, "target":target_language, "q":contents}))
### -----------------------------------------------------------------------------------------------

### Private Methods -------------------------------------------------------------------------------
func _on_translation_received(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	if response_code != 200 : 
		print(JSON.parse(body.get_string_from_utf8()).result)
	emit_signal("translation_received", [response_code,JSON.parse(body.get_string_from_utf8()).result])
### -----------------------------------------------------------------------------------------------
