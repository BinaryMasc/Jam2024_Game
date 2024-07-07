extends Node2D

class_name Office1

var sub_controller: SubtitleController

var first_interaction:= true
var second_interaction:= true

#var reports: Reports
#var hands: Hands
#var cubicle: Cubicle


# Called when the node enters the scene tree for the first time.
func _ready():
	sub_controller = $SubtitleController
	#reports = $Reports
	#hands = $Soap
	#cubicle = $Cubicle
	#reports.connect("reports_pressed_event", _on_reports_pressed)
	#hands.connect("hands_pressed_event", _on_hands_pressed)
	#cubicle.connect("cubicle_pressed_event", _on_cubicle_pressed)
	story_flow_1()


func story_flow_1():
	sub_controller.new_subtitle("aaaa", "aaaaaaaaaaaaaaaa")
	pass

