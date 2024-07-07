extends Area2D

class_name Cat

var mouse_over:= false
var animation: AnimatedSprite2D
var sub_controller: SubtitleController

# Called when the node enters the scene tree for the first time.
func _ready():
	animation = $AnimatedSprite2D
	sub_controller = get_node("../SubtitleController")
	animation.show()
	#animation.play()
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


signal cat_pressed_event()

func _on_mouse_entered():
	mouse_over = true
	
func _on_mouse_exited():
	mouse_over = false

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and mouse_over:
			#print("click sobre el objeto")
			if sub_controller.allow_external_interactions():
				emit_signal("cat_pressed_event")
				#animation.show()
				animation.play()
			return
		
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			print("click 2")

