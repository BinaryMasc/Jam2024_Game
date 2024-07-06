extends Node2D


class_name Soap

var sub_controller: SubtitleController
var cat: Cat

# Escena controller

# Called when the node enters the scene tree for the first time.
func _ready():
	sub_controller = $SubtitleController
	cat = $Cat
	cat.connect("cat_pressed_event", _on_cat_pressed)
	story_flow_1()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func story_flow_1():
	sub_controller.new_subtitle("", "")
	sub_controller.new_subtitle("", "Trabajo en una compañía de seguros llamada SeguraTes... Si, lo sé. Pero, quién soy yo para cuestionar decisiones empresariales de altos ejecutivos.")
	sub_controller.new_subtitle("", "Soy un oficinista, y es mi segundo día de trabajo, solo que decidí tomarme un pequeño descanso.")
	sub_controller.new_subtitle("Tú", "Ahora, estoy en el baño.")
	
	sub_controller.new_subtitle("", "Estas en el baño de la oficina, llevas un tiempo ahi, pero quizás puedas hacer algo más aquí antes de volver a tu puesto.");

func story_flow_2():
	sub_controller.new_subtitle("Tú", "¿Eh? ¿Quién dijo eso?")
	sub_controller.new_subtitle("Tú", "Bueno, no estoy loco, seguro es por el agotamiento.")
	#sub_controller.button_pressed_callback = Callable(self, "story_flow_decision_2")
	sub_controller.new_subtitle("Tú", "Pero espera, se supone que esto es un \"descanso\".")
	#Thread.new().start(Callable(self, "story_flow_decision_2"))
	#Callable(self, "story_flow_decision_2")
	#sub_controller.new_subtitle("Felix", "¿Debería quedarme más tiempo aquí?")
	sub_controller.new_subtitle_callback("Tú", "¿Debería quedarme más tiempo aquí?", Callable(self, "story_flow_decision_2"))

func story_flow_2_1():
	pass

func story_flow_decision_2():
	#print("story_flow_decision_2")
	sub_controller.new_question("Sí", "No", "Comerse el jabón", Callable(self, "story_flow_4"), 10)
	#sub_controller.new_subtitle("Felix", "¿Debería quedarme más tiempo aquí?")

func story_flow_4(option: int):
	if option == 1:
		sub_controller.new_subtitle("Tú", "Me quedo.")
		sub_controller.new_subtitle_callback("Felix", "¿Ahora, qué hago?", Callable(self, "story_flow_decision_2"))
		
		
	elif option == 2:
		sub_controller.new_subtitle("", "Ir a la oficina..." )
		
	elif option == 3:
		sub_controller.new_subtitle("", "Muchos carbohidratos, ¿No crees?")
	
	else:
		sub_controller.new_subtitle("", "Se ha acabado el tiempo.")
		sub_controller.new_subtitle("", "Lo siento.")
		sub_controller.new_subtitle("", "Has perdido.")
		

func _on_cat_pressed():
	#print("Señal recibida con argumento: ", argumento)
	sub_controller.new_subtitle("Felix", "Que lindo gato.")
	pass
