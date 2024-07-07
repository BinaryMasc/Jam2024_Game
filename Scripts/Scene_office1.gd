extends Node2D

class_name Office1

var sub_controller: SubtitleController

var first_interaction:= true
var second_interaction:= true

var reports: Reports
var hands: Hands
#var cubicle: Cubicle


# Called when the node enters the scene tree for the first time.
func _ready():
	sub_controller = $SubtitleController
	reports = $Reports
	hands = $Hands
	#cubicle = $Cubicle
	reports.connect("reports_pressed_event", _on_reports_pressed)
	hands.connect("hands_pressed_event", _on_hands_pressed)
	#cubicle.connect("cubicle_pressed_event", _on_cubicle_pressed)
	story_flow_1()


func story_flow_1():
	sub_controller.new_subtitle("", "Sales del baño, aún con algo de agua en las manos. ")
	sub_controller.new_subtitle("Tú", "Mierda. Bueno, creo que si me las seco con el pantalón no se notará...")
	sub_controller.new_subtitle("Jefe", "¡OYE TU!¡CHICO NUEVO! ¡¿POR QUÉ TARDABAS TANTO?!")
	sub_controller.new_subtitle("Jefe", "DA IGUAL, TOMA ESTOS REPORTES Y LLEVASELOS A ALICE, LA EMPLEADA DE PASO.")
	sub_controller.new_subtitle("Jefe", "¡TIENEN QUE ESTAR REGISTRADOS Y ARCHIVADOS PARA AYER!")
	pass

var hands_pressed:= false
func _on_hands_pressed():
	if not hands_pressed:
		sub_controller.new_subtitle("", "hands")
	hands_pressed = true

var reports_pressed:= false
func _on_reports_pressed():
	if not cubicle_pressed and not hands_pressed:
		sub_controller.new_subtitle("", "Sin pensarlo, instintivamente le asientes al Jefe y extiendes tus manos para recibir el papeleo. ")
	reports_pressed = true
	sub_controller.new_subtitle("", "El jefe te pasa los reportes. Tus aun mojadas manos los toman, intentando que no se caigan y antes de darte cuenta, tu jefe se aleja dando zancadas a su oficina. ")
	sub_controller.new_subtitle("", "Los papeles claramente se humedecen, afortunadamente no lo suficiente para romper las hojas.")
	sub_controller.new_subtitle("", "¿Pero que tan grave es realmente el daño?")
	sub_controller.new_subtitle("Tú", "Mierda, esto no va a llevar a nada bueno...")
	sub_controller.new_subtitle("Tú", "Te das la vuelta para ir hacia el cubículo de Alice, pero antes de que puedas lograrlo, ella se aparece en frente de ti.")
	sub_controller.new_subtitle("Alice", "¡Oh, lo siento! casi me tropiezo contigo.")
	sub_controller.new_subtitle("Alice", "Lo siento, tengo un poco de prisa. Tengo que ir a enviar unos emails.")
	sub_controller.new_subtitle("Alice", "Oh... mas reportes.")
	sub_controller.new_subtitle_callback("Alice", "Supongo que son para mí.", _question_1_flow_reports)

var cubicle_pressed:= false
func _on_cubicle_pressed():
	if not cubicle_pressed:
		sub_controller.new_subtitle("", ".")
	cubicle_pressed = true

# Reportes o cubículo
func _question_1_flow_reports():
	sub_controller.new_question("Reportes", "", "Cubículo", _on_choose_question_1)

func _on_choose_question_1(option: int):
	if option == 1:
		_on_choose_question_1_flow_1()

	elif option == 3:
		_on_choose_question_1_flow_2()

func _on_choose_question_1_flow_1():
	sub_controller.new_subtitle("Alice", "Le pasas los reportes empapados a Alice y ella los recibe, con una expresión cansada.")
	sub_controller.new_subtitle("Alice", "¿Por qué están mojados?")
	sub_controller.new_subtitle("Tú", "Lo siento, yo...")
	sub_controller.new_subtitle("Alice", "Oh... No te preocupes, seguro no fue tu culpa.")
	sub_controller.new_subtitle("Alice", "¿Nunca se va a acabar, cierto?")
	sub_controller.new_subtitle("", "Ella se va sin decirte nada, con una expresión sombría.")
	sub_controller.new_subtitle("Tú", "¿Debería haber hecho otra cosa?")
	_flow_penultimate()

func _on_choose_question_1_flow_2():
	sub_controller.new_subtitle("Tú", "¡No!, no, descuida, yo me encargo.")
	sub_controller.new_subtitle("Alice", "¿Estas seguro?")
	sub_controller.new_subtitle("Tú", "Si, trabajamos en una compañía de seguros ¿recuerdas?... Ja.")
	sub_controller.new_subtitle("Tú", "...")
	sub_controller.new_subtitle("Tú", "Bueno, creo que ire a ponerme a trabajar en esto, y en lo demás...")
	sub_controller.new_subtitle("Alice", "Si, suerte con el trabajo.")
	sub_controller.new_subtitle("Alice", "¡Nos vemos luego!")
	sub_controller.new_subtitle("", "Ella se retira hacia el otro lado de la oficina, claramente con una expresión de estrés, pero por lo menos satisfecha de no tener más trabajo que hacer.")
	sub_controller.new_subtitle("Tú", "Genial... Ahora ¿qué se supone que haré con esto?")
	sub_controller.new_subtitle("", "Tardas al menos 8 horas trabajando en reescribir los reportes mojados y entregarlos. Ahora te sientes agotado.")
	_flow_last()


func _flow_penultimate():
	sub_controller.new_subtitle("Tú", "Supongo que debería ponerme a trabajar ahora.")
	sub_controller.new_subtitle("Tú", "Tardas al menos 8 horas Terminando tu trabajo atrasado.")
	_flow_last()
	

func _flow_last():
	sub_controller.new_subtitle("Tú", "Uf, eso fue terrible.")
	sub_controller.new_subtitle("Tú", "Debería volver al baño, quizás descansar un rato... Nisiquiera sé cuando termina mi turno.")
	sub_controller.new_subtitle("Tú", "Regresas al baño rapidamente y cierras la puerta.")
	sub_controller.new_subtitle("", "Cambio de escena.")
