extends Area2D

class_name Nail_polish


var mouse_over:= false
var story_controller: Node2D
var sub_controller: SubtitleController


func _ready():
	sub_controller = get_node("../SubtitleController")
	story_controller = get_node("../../Node2D")
	
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	

signal nail_polish_pressed_event()

#func _process(delta):
#	pass

func _on_mouse_entered():
	mouse_over = true
	
func _on_mouse_exited():
	mouse_over = false

func _input(event):
	if event is InputEventMouseButton:
		
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and mouse_over:
			#print("click sobre el objeto")
			if sub_controller.allow_external_interactions():
				emit_signal("nail_polish_pressed_event")
			return
		
		#if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			#print("click 2")
