extends Node2D


class_name Soap

var sub_controller: SubtitleController

# Escena controller

# Called when the node enters the scene tree for the first time.
func _ready():
	story_flow_1()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func story_flow_1():
	sub_controller = get_node("/root/Node2D/SubtitleController")
	sub_controller.new_subtitle("", "Hoy es 25 de Marzo de 1997, mi nombre es Felix Alderson y tengo 23 años.")
	sub_controller.new_subtitle("", "Vivo en los apartamentos de la calle Rhapsody nro. 35. No estoy casado ni tengo hijos.")
	sub_controller.new_subtitle("", "Trabajo en una compañía de seguros llamada SeguraTes... Si, lo sé. Pero quien soy yo para cuestionar decisiones empresariales avanzadas.")
	sub_controller.new_subtitle("", "Soy un oficinista, y es mi segundo día de trabajo, solo que decidí tomarme un pequeño descanso.")
	
	sub_controller.new_subtitle("Felix", "Ahora estoy en el baño.")
	
	sub_controller.new_subtitle("Narrador", "Estás en el baño de la oficina, llevas un tiempo ahi, pero quizás puedas hacer algo más aquí antes de volver a tu puesto.");

func story_flow_2():
	sub_controller.new_subtitle("Felix", "¿Eh? ¿Quién dijo eso?")
	sub_controller.new_subtitle("Felix", "Bueno, no estoy loco, seguro es por el agotamiento.")
	sub_controller.new_subtitle("Felix", "Pero espera, se supone que esto es un \"descanso\".")
	sub_controller.new_subtitle_callback("Felix", "¿Debería quedarme más tiempo aquí?", Callable(self, "story_flow_decision_2"))
	#sub_controller.button_pressed_callback = Callable(self, "story_flow_decision_2")

func story_flow_2_1():
	pass

func story_flow_decision_2():
	print("story_flow_decision_2")
	sub_controller.button_pressed_callback = Callable(self, "story_flow_4")
	sub_controller._enable_and_show_buttons(0, "Sí", "No", "Comerse el jabón")

func story_flow_4(option: int):
	if option == 1:
		sub_controller.new_subtitle("", "Ir a la oficina..." )
		
	elif option == 2:
		sub_controller.new_subtitle("Felix", "Me quedo.")
		
	else:
		sub_controller.new_subtitle("", "Muchos carbohidratos, ¿No crees?")

