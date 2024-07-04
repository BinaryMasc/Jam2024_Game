extends Node


class_name Message

var msg: String
var callback: Callable
var has_callback:= false

func _init(new_msg: String):
	msg = new_msg
	
func set_callback(new_callback: Callable):
	callback = new_callback
	has_callback = true
	return self
