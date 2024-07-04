extends Area2D

var mouse_over:= false
var story_controller: Node2D
var sub_controller: SubtitleController
var cat: Cat

func _ready():
	sub_controller = get_node("/root/Node2D/SubtitleController")
	story_controller = get_node("/root/Node2D")
	cat = get_node("/root/Node2D/Cat")
	
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	


func _process(delta):
	pass

func _on_mouse_entered():
	#print("mouse enter")
	mouse_over = true
	
func _on_mouse_exited():
	#print("mouse exited")
	mouse_over = false

func _input(event):
	if event is InputEventMouseButton:
		
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and mouse_over:
			#print("click sobre el objeto")
			if not sub_controller.is_subs_running() and sub_controller.get_subs_size() == 0:
				cat.animation.show()
				cat.animation.play()
				sub_controller.new_subtitle("Felix", "Que suerte, por lo menos cumplen con las reglas básicas de higiene en este lugar.")
				sub_controller.new_subtitle("...", "Te bañaste hoy ¿Verdad?")
				sub_controller.new_subtitle("", "...")
				sub_controller.new_subtitle("...", "¡¿Verdad?!")
				story_controller.story_flow_2()
			return
		
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			print("click 2")
