extends Node2D


class_name Scene_1

var first_interaction:= true
var second_interaction:= true

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
	nail_polish = $Nail_polish
	door = $Door
	flowerpot = $Flowerpot
	
	cat.connect("cat_pressed_event", _on_cat_pressed)
	soap.connect("soap_pressed_event", _on_soap_pressed)
	mirror.connect("mirror_pressed_event", _on_mirror_pressed)
	nail_polish.connect("nail_polish_pressed_event", _on_nail_polish_pressed)
	flowerpot.connect("flowerpot_pressed_event", _on_flowerpot_pressed)
	door.connect("door_pressed_event", _on_door_pressed)
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

# quedarme?
func story_flow_decision_stay():
	sub_controller.new_question("Sí", "", "No", story_flow_4)
	#sub_controller.new_subtitle("Felix", "¿Debería quedarme más tiempo aquí?")

func story_flow_decision_3():
	sub_controller.new_question("Sí", "", "No", story_flow_5, 2)
	
# Ir a la oficina
func story_flow_decision_4():
	sub_controller.new_question("No", "", "Sí", story_flow_4)

func story_flow_4(option: int):
	if option == 1:
		sub_controller.new_subtitle("Tú", "Me quedo.")
		#sub_controller.new_subtitle_callback("Felix", "¿Ahora, qué hago?", story_flow_decision_2)

	elif option == 3:
		#sub_controller.new_subtitle("", "Ir a la oficina...")
		_scene_end()

# Llamado al finalizar la escena
func story_flow_5(option: int):
	if option == 1:
		sub_controller.new_subtitle("", "Intentas desesperadamente coger papel higiénico para secarte las manos.")
		sub_controller.new_subtitle("", "Con las prisas, se cae el papel en el suelo.")
		sub_controller.new_subtitle("", "No te da tiempo de limpiarte las manos, por lo que igual decides salir con las manos mojadas.")

	elif option == 3:
		sub_controller.new_subtitle("", "Sales con las manos mojadas")
		
	else:
		sub_controller.new_subtitle("", "Se te hizo tarde tomar una decisión y saliste con las manos mojadas.")
	
	sub_controller.new_subtitle("", "cambio de escena.")

func _on_cat_pressed():
	sub_controller.new_subtitle("Mephisto", "...")
	pass

var mirror_pressed:= false
func _on_mirror_pressed():
	if mirror_pressed:
		return
	mirror_pressed = true
	sub_controller.new_subtitle("Tú", "Bueno, no me veo tan mal para ser mi primera semana.")
	sub_controller.new_subtitle("Mephisto", "¿Estas seguro de que seguirás pensando lo mismo la próxima?")
	_validate_first_interaction()
	#sub_controller.new_subtitle_callback("Tú", "¿Debería quedarme más tiempo aquí?", story_flow_decision_stay)

var nail_polish_pressed:= false
func _on_nail_polish_pressed():
	if nail_polish_pressed:
		return
	nail_polish_pressed = true
	sub_controller.new_subtitle("Tú", "Si, la oficina no es muy grande por lo que tenemos un baño por sección. Y es compartido entre ambos sexos...")
	sub_controller.new_subtitle("Needy", "Quizás, ya es el momento de tener a alguien en tu vida.")
	_validate_first_interaction()
	#sub_controller.new_subtitle_callback("Tú", "¿Debería quedarme más tiempo aquí?", story_flow_decision_stay)

var soap_pressed:= false
func _on_soap_pressed():
	if soap_pressed:
		return
	#print("Señal recibida con argumento: ", argumento)
	sub_controller.new_subtitle("Tú", "Que suerte, por lo menos cumplen con las reglas básicas de higiene en este lugar.")
	sub_controller.new_subtitle("Cynical", "Te bañaste hoy ¿Verdad?")
	sub_controller.new_subtitle("", "...")
	sub_controller.new_subtitle("Cinical", "¡¿Verdad?!")
	soap_pressed = true
	_validate_first_interaction()
	#sub_controller.new_subtitle_callback("Tú", "¿Debería quedarme más tiempo aquí?", story_flow_decision_stay)
	#sub_controller.new_subtitle_callback("Tú", "¿Debería quedarme más tiempo aquí?", story_flow_decision_2)

var flowerpot_pressed:= false
func _on_flowerpot_pressed():
	if flowerpot_pressed:
		return
	sub_controller.new_subtitle("", "La maceta tiene una planta joven adornada con tres flores, una color purpura, una de color amarillo y otra de color naranja.")
	sub_controller.new_subtitle("Tú", "Alguien aquí tiene buen gusto pero... ")
	sub_controller.new_subtitle("", "Tu dedo índice toca la planta suavemente...")
	sub_controller.new_subtitle("", "¿Como puede crecer esta planta aquí, estando atrapada y sin sol?")

	flowerpot_pressed = true
	#_validate_first_interaction()
	
var door_pressed:= false
func _on_door_pressed():
	if door_pressed:
		sub_controller.new_subtitle_callback("Tú", "¿Salir del baño?", story_flow_decision_4)
		return
	
	sub_controller.new_subtitle("", "Pasas un rato contemplando la puerta, pensando si ya es momento de regresar a tu lugar para esperar a que pase el día.")
	sub_controller.new_subtitle("", "Antes de eso, intentas concentrarte para mezclarte con tus pensamientos y reflexionar.")
	sub_controller.new_subtitle("", "¿Pero reflexionar sobre qué? Esto no está resultando como esperabas.")
	sub_controller.new_subtitle("Tú", "¿Quizás deberías quedarte un poco más de tiempo?")
	sub_controller.new_subtitle_callback("Tú", "¿Quizás deberías quedarte un poco más de tiempo?", story_flow_decision_stay)

	door_pressed = true
	#_validate_first_interaction()


func _validate_first_interaction():
	if not first_interaction:
		if not second_interaction:
			pass
		else:
			sub_controller.new_subtitle("Tú", "Lo preguntaré otra vez ¡¿Quién dijo eso?!")
			sub_controller.new_subtitle("Tú", "¿Hola?")
		
	sub_controller.new_subtitle("Tú", "¿Eh? ¿Quién dijo eso?")
	sub_controller.new_subtitle("Tú", "Bueno, no estoy loco, seguro es por el agotamiento.")
	sub_controller.new_subtitle("Tú", "Pero espera, se supone que esto es un \"descanso\".")
	first_interaction = false
	
	if soap_pressed and nail_polish_pressed and mirror_pressed:
		sub_controller.new_subtitle("Tú", "Bueno, ya es hora de irse.")
		_scene_end()
		

func _scene_end():
	sub_controller.new_subtitle("Tú", "Creo que ya fue suficiente descanso,  volvamos al trabajo.")
	sub_controller.new_subtitle("", "Oyes a alguien tocando la puerta a golpes. Parece impaciente.")
	sub_controller.new_subtitle("Tú", "¡YA CASI SALGO!")
	sub_controller.new_subtitle("Tú", "Demonios, mis manos siguen mojadas.")
	sub_controller.new_subtitle_callback("Tú", "¿Debería secarme las manos?", story_flow_decision_3)
	# conecta con la función story_flow_5 para concluír la escena
