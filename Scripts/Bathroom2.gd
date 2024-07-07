extends Node

class_name Bathroom2

var first_interaction:= true
var second_interaction:= true
var change_scene_flag:= false

var sub_controller: SubtitleController
var cat: Cat
var soap: Soap
var nail_polish: Nail_polish
var mirror: Mirror
var door: Door
var flowerpot: Flowerpot



# Escena controller

# Called when the node enters the scene tree for the first time.
func _ready():
	sub_controller = $SubtitleController
	cat = $Cat
	soap = $Soap
	mirror = $Mirror
	#nail_polish = $Nail_polish
	door = $Door
	flowerpot = $Flowerpot
	
	cat.connect("cat_pressed_event", _on_cat_pressed)
	soap.connect("soap_pressed_event", _on_soap_pressed)
	mirror.connect("mirror_pressed_event", _on_mirror_pressed)
	#nail_polish.connect("nail_polish_pressed_event", _on_nail_polish_pressed)
	flowerpot.connect("flowerpot_pressed_event", _on_flowerpot_pressed)
	door.connect("door_pressed_event", _on_door_pressed)
	story_flow_1()

func story_flow_1():
	sub_controller.new_subtitle("", "Estas nuevamente en el baño. Solo. \nCon tus pensamientos.")

var cat_pressed:= false
func _on_cat_pressed():
	
	sub_controller.new_subtitle("Mephisto", "prueba")
	cat_pressed = true


var soap_pressed:= false
func _on_soap_pressed():
	sub_controller.new_subtitle("Soap", "prueba1")
	
	soap_pressed = true
	
var mirror_pressed:= false
func _on_mirror_pressed():
	sub_controller.new_subtitle("Mirror", "prueba1")
	
	mirror_pressed = true

var flowerpot_pressed:= false
func _on_flowerpot_pressed():
	sub_controller.new_subtitle("", "Observas la maceta de antes. te das cuenta de que las plantas están diferentes a la ultima vez que las viste.")
	
	flowerpot_pressed = true

var door_pressed:= false
func _on_door_pressed():
	sub_controller.new_subtitle("door", "prueba1")
	
	door_pressed = true
