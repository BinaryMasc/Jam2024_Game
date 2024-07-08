extends Node2D

class_name Office1

var sub_controller: SubtitleController

var first_interaction:= true
var second_interaction:= true
var change_scene_flag:= false

var reports: Reports
var hands: Hands
var cubicle: Cubicle


var show_boss:= false
var show_freddy:= false
var show_rafael:= false
var show_hector:= false
var show_alice:= false
var show_mike:= false

func _ready():
	sub_controller = $SubtitleController
	reports = $Reports
	hands = $Hands
	cubicle = $Cubicle
	$Door_sound.play()
	$OfficeAmbient.stream.loop = true
	$OfficeAmbient.play()
	
	reports.connect("reports_pressed_event", _on_reports_pressed)
	hands.connect("hands_pressed_event", _on_hands_pressed)
	cubicle.connect("cubicle_pressed_event", _on_cubicle_pressed)
	story_flow_1()

func _process(delta):
	if change_scene_flag:
		get_tree().change_scene_to_file("res://Scenes/Bathroom2.tscn")
		return
		
	if show_boss:
		$Jefe.show()
	else:
		$Jefe.hide()
		
	if show_freddy:
		$Freddy.show()
	else:
		$Freddy.hide()
	
	if show_hector:
		$Hector.show()
	else:
		$Hector.hide()
	
	if show_rafael:
		$Rafael.show()
	else:
		$Rafael.hide()
		
	if show_alice:
		$Alice.show()
	else:
		$Alice.hide()
		
	if show_mike:
		$Mike.show()
		$Oficina1.hide()
	else:
		$Mike.hide()
		$Oficina1.show()

func story_flow_1():
	sub_controller.new_subtitle("", "Sales del baño, aún con algo de agua en las manos. ")
	sub_controller.new_subtitle_callback("Tú", "Mierda. Bueno, creo que si me las seco con el pantalón no se notará...", _jefe_hide_show.bind(true))

	sub_controller.new_subtitle("Jefe", "¡OYE, TÚ! ¡CHICO NUEVO! ¡¿POR QUÉ TARDABAS TANTO?!")
	sub_controller.new_subtitle("Jefe", "DA IGUAL, TOMA ESTOS REPORTES Y LLEVASELOS A ALICE, LA EMPLEADA DE PASO.")
	sub_controller.new_subtitle_callback("Jefe", "¡TIENEN QUE ESTAR REGISTRADOS Y ARCHIVADOS PARA AYER!", _question_0_flow_reports)
	

func _question_0_flow_reports():
	sub_controller.new_question("Mostrarle las\nmanos mojadas", "Tomar\nreportes", "Ir al\ncubículo", _on_choose_question_0)
	

func _on_choose_question_0(option: int):
	if option == 1:
		_on_hands_pressed()
	
	elif option == 2:
		_on_reports_pressed()
	
	elif option == 3:
		_on_cubicle_pressed()


var hands_pressed:= false
func _on_hands_pressed():
	if not hands_pressed:
		sub_controller.new_subtitle("Tú", "Pero jefe, yo...")
		sub_controller.new_subtitle_callback("Jefe", "¡¿QUÉ QUIERES?!", _question_0_flow_reports)
		hands_pressed = true
	else: 
		sub_controller.new_subtitle("", "Levantas tus manos de manera que tu jefe las pueda ver entre los reportes.")
		sub_controller.new_subtitle("Tú", "Jefe... eh...Yo...")
		sub_controller.new_subtitle("Tú", "CON UN DEMONIO ¿POR QUÉ TIENES QUE SER TAN INUTIL?")
		sub_controller.new_subtitle("", "Rápidamente se acerca un sujeto amigable hacia ti y tu jefe.")

		sub_controller.new_subtitle_callback("Freddy", "Oiga jefe, tranquilo, yo me encargo, los llevaré por usted.", _freddy_hide_show.bind(true))
		sub_controller.new_subtitle("Jefe", "PERFECTO, ALMENOS ALGUIEN AQUÍ SABE COMO TIENEN QUE SER LAS COSAS.")
		sub_controller.new_subtitle_callback("Jefe", "NO COMO OTROS.", _jefe_hide_show.bind(false))

		sub_controller.new_subtitle("", "El jefe se retira en otra dirección, dejando los reportes en manos del chico amable.")
		sub_controller.new_subtitle("Freddy", "Vaya, eso fue estresante ¿Estas bien?")
		sub_controller.new_subtitle("Tú", "Gracias, yo...")
		sub_controller.new_subtitle("Freddy", "No te preocupes, oye. Mientras yo llevo esto ¿Podrías ir a llevarle este USB a Mike? es el chico de informática.")
		sub_controller.new_subtitle("Tú", "Pero, tengo que volver a mi puesto. Tengo trabajo que no he terminado...")
		sub_controller.new_subtitle_callback("Freddy", "Tranquilo, el trabajo al lado de tu puesto. No te tomará nada. Tampoco quiero causarte problemas ¿Qué dices?", _question_2_flow_reports)


var reports_pressed:= false
func _on_reports_pressed():
	if not cubicle_pressed and not hands_pressed:
		sub_controller.new_subtitle("", "Sin pensarlo, instintivamente le asientes al Jefe y extiendes tus manos para recibir el papeleo. ")
	reports_pressed = true
	sub_controller.new_subtitle("", "El jefe te pasa los reportes. Tus aun mojadas manos los toman, intentando que no se caigan y antes de darte cuenta, tu jefe se aleja dando zancadas a su oficina. ")
	sub_controller.new_subtitle("", "Los papeles claramente se humedecen, afortunadamente no lo suficiente para romper las hojas.")
	sub_controller.new_subtitle("", "¿Pero que tan grave es realmente el daño?")
	sub_controller.new_subtitle_callback("Tú", "Mierda, esto no va a llevar a nada bueno...", _jefe_hide_show.bind(false))
	sub_controller.new_subtitle_callback("Tú", "Te das la vuelta para ir hacia el cubículo de Alice, pero antes de que puedas lograrlo, ella se aparece en frente de ti.", _alice_hide_show.bind(true))
	sub_controller.new_subtitle("Alice", "...")
	sub_controller.new_subtitle("Alice", "¡Oh! casi me tropiezo contigo.")
	sub_controller.new_subtitle("Alice", "Tengo un poco de prisa. Tengo que ir a enviar unos emails.")
	sub_controller.new_subtitle("Alice", "Oh... mas reportes.")
	sub_controller.new_subtitle_callback("Alice", "Supongo que son para mí.", _question_1_flow_reports)

var cubicle_pressed:= false
func _on_cubicle_pressed():
	sub_controller.new_subtitle("Tú", "Disculpe jefe, pero aun no he terminado mis reportes, opino que debería volver a mi puesto...")
	sub_controller.new_subtitle_callback("Jefe", "¡¡PUES DEBISTE TERMINARLOS ANTES!!", _question_3_flow_reports)
	
	cubicle_pressed = true

# Reportes o cubículo
func _question_1_flow_reports():
	sub_controller.new_question("Entregar", "", "Hacerlo tú mismo", _on_choose_question_1)

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
	sub_controller.new_subtitle_callback("", "Ella se va sin decirte nada, con una expresión sombría.", _alice_hide_show.bind(false))

	sub_controller.new_subtitle("Tú", "¿Debería haber hecho otra cosa?")
	_flow_penultimate()

func _on_choose_question_1_flow_2():
	sub_controller.new_subtitle("Tú", "¡No!, no, descuida, yo me encargo.")
	sub_controller.new_subtitle("Alice", "¿Estas seguro?")
	sub_controller.new_subtitle("Tú", "Si, trabajamos en una compañía de seguros ¿recuerdas?... Ja.")
	sub_controller.new_subtitle("Tú", "...")
	sub_controller.new_subtitle("Tú", "Bueno, creo que ire a ponerme a trabajar en esto, y en lo demás...")
	sub_controller.new_subtitle("Alice", "Si, suerte con el trabajo.")
	sub_controller.new_subtitle_callback("Alice", "¡Nos vemos luego!", _alice_hide_show.bind(false))

	sub_controller.new_subtitle("", "Ella se retira hacia el otro lado de la oficina, claramente con una expresión de estrés, pero por lo menos satisfecha de no tener más trabajo que hacer.")
	sub_controller.new_subtitle("Tú", "Genial... Ahora ¿qué se supone que haré con esto?")
	sub_controller.new_subtitle("", "Tardas al menos 8 horas trabajando en reescribir los reportes mojados y entregarlos. Ahora te sientes agotado.")
	_flow_last()

func _question_2_flow_reports():
	sub_controller.new_question("Negarse e ir\na trabajar", "", "Coger USB", _on_choose_question_2)

func _on_choose_question_2(option: int):
	if option == 1:
		_on_choose_question_2_flow_1()

	elif option == 3:
		_on_choose_question_2_flow_2()

func _hector_hide_show(show: bool):
	show_hector = show

func _jefe_hide_show(show: bool):
	show_boss = show

func _alice_hide_show(show: bool):
	show_alice = show

func _freddy_hide_show(show: bool):
	show_freddy = show

func _rafael_hide_show(show: bool):
	show_rafael = show

func _rafael_hector_hide_show(show: bool):
	show_rafael = show
	show_hector = show

func _mike_hide_show(show: bool):
	show_mike = show

func _on_choose_question_2_flow_1():
	sub_controller.new_subtitle("Tú", "Lo siento, de verdad tengo mucho trabajo...")
	sub_controller.new_subtitle("Freddy", "Entiendo, no te preocupes, me encargaré yo. ¡Siempre encuentro el tiempo!")
	sub_controller.new_subtitle_callback("Freddy", "¡Suerte!", _freddy_hide_show.bind(false))
	
	sub_controller.new_subtitle("", "El agradable sujeto desaparece entre los pasillos y la gente yendo de lado a lado.")
	sub_controller.new_subtitle("Tú", "Creo que sonaba un poco decepcionado...")
	_flow_penultimate()

func _on_choose_question_2_flow_2():
	sub_controller.new_subtitle("Tú", "Si, está bien... Yo le paso el USB")
	sub_controller.new_subtitle("Freddy", "...")
	sub_controller.new_subtitle_callback("Freddy", "Gracias.", _freddy_hide_show.bind(false))
	sub_controller.new_subtitle("", "El sujeto desaparece entre los pasillos y la gente yendo de lado a lado.")
	sub_controller.new_subtitle_callback("", "Te diriges al cubículo de al lado donde te encuentras al sujeto en cuestión.", _mike_hide_show.bind(true))
	sub_controller.new_subtitle("", "...")
	sub_controller.new_subtitle("", "No te está prestando atención.")
	sub_controller.new_subtitle("Tú", "¿Hola?")
	sub_controller.new_subtitle("", "Sigue sin prestarte atención, así que le pones una mano en la pantalla de su ordenador.")
	sub_controller.new_subtitle("Mike", "¿Ah? ¿Que quieres?")
	sub_controller.new_subtitle("Tú", "Hey, perdón por molestar pero me dijeron que te diera esto.")
	sub_controller.new_subtitle("Mike", "Ah si, necesitaba eso.")
	sub_controller.new_subtitle("Mike", "...")
	sub_controller.new_subtitle("", "Sigue en lo suyo en su ordenador.")
	sub_controller.new_subtitle("Tú", "Oye solo por curiosidad ¿Que estabas haciendo?")
	sub_controller.new_subtitle("Mike", "Estaba jugando un videojuego, se llama Treta 3. Deberías jugarlo.")
	sub_controller.new_subtitle("Tú", "Pero, ¿no tienes miedo de que te despidan?")
	sub_controller.new_subtitle("Mike", "No, es muy simple. Si me despiden, les saboteo las bases de datos a la empresa.")
	sub_controller.new_subtitle("Mike", "Además, todos aquí son unos incompetentes que no pueden mantener la pobre infraestructura que queda.")
	sub_controller.new_subtitle("Mike", "¿Ya podrías irte? Necesito seguir farmeando para comprar una armadura.")
	sub_controller.new_subtitle("Tú", "Oh... Bueno, no te molesto más. Me iré a trabajar.")
	sub_controller.new_subtitle("Mike", "Como quieras.")
	sub_controller.new_subtitle_callback("", "Vuelves a tu cubículo", _mike_hide_show.bind(false))
	
	_flow_penultimate()
	

func _question_3_flow_reports():
	sub_controller.new_question("Reportes", "", "Cubículo", _on_choose_question_3)

func _on_choose_question_3(option: int):
	if option == 1:
		_on_choose_question_3_flow_1()

	elif option == 3:
		_on_choose_question_3_flow_2()

func _on_choose_question_3_flow_1():
	sub_controller.new_subtitle("Tú", "Pero ayer me hizo hacer otra cosa...")
	sub_controller.new_subtitle("Jefe", "¡¡TIENES QUE SER MAS PROACTIVO!!¡¿COMO ESPERAS JUSTIFICAR TU SUELDO DE ESA FORMA?!")
	sub_controller.new_subtitle("Jefe", "AHORA SE ÚTIL Y LLEVATE ESTOS REPORTES.")
	_on_reports_pressed()

func _on_choose_question_3_flow_2():
	sub_controller.new_subtitle("Tú", "¡Voy a terminarlos ahora! ¡No me demoro!")
	sub_controller.new_subtitle("Jefe", "¡OLVIDALO, ERES UNA TORTUGA, HARÉ QUE FREDERICK LOS LLEVE!")
	sub_controller.new_subtitle_callback("", "El jefe se retira en otra dirección, hacia un cubículo no muy lejos del tuyo.", _jefe_hide_show.bind(false))
	sub_controller.new_subtitle("Tú", "Bueno, por lo menos ahora si puedo trabajar...")
	sub_controller.new_subtitle("", "Te sientas en tu cubículo, pero pasados unos pocos minutos llegan dos sujetos a tu puesto.")
	
	sub_controller.new_subtitle_callback("Rafael", "Buenas tardes, amigo, disculpa las molestias.", _rafael_hector_hide_show.bind(true))
	sub_controller.new_subtitle("Héctor", "Espero no estés haciendo nada importante, te queríamos pedir un favor.")
	sub_controller.new_subtitle("Tú", "Yo...")
	sub_controller.new_subtitle("Héctor", "Perfecto, el favor es el siguiente:")
	sub_controller.new_subtitle("Rafael", "Mi amigo y yo tenemos que entregarle al jefe una presentación sobre productividad en el area de trabajo.")
	sub_controller.new_subtitle("Héctor", "Y la verdad es que tenemos tanto trabajo aplazado que no hemos podido avanzar mucho.")
	sub_controller.new_subtitle("Rafael", "Y la presentación es para mañana.")
	sub_controller.new_subtitle("Héctor", "Por lo tanto, te queremos incluir a ti para que podamos terminar más \"rápido\".")
	sub_controller.new_subtitle_callback("Rafael", "¿Qué dices?", _question_4_flow_reports)
	

func _question_4_flow_reports():
	sub_controller.new_question("Aceptar", "", "Rechazar", _on_choose_question_4)

func _on_choose_question_4(option: int):
	if option == 1:
		_on_choose_question_4_flow_1()

	elif option == 3:
		_on_choose_question_4_flow_2()

func _on_choose_question_4_flow_1():
	sub_controller.new_subtitle("Tú", "Vale, está bien...Yo me encargo.")
	sub_controller.new_subtitle("Rafael", "Genial, sabíamos que podíamos contar contigo.")
	sub_controller.new_subtitle("Héctor", "Te debemos una socio. mas adelante te invitamos una pizza.")
	sub_controller.new_subtitle("Tú", "En... ¿En serio?")
	sub_controller.new_subtitle("Rafael", "¿En serio?")
	sub_controller.new_subtitle("Rafael", "¿En serio?")
	sub_controller.new_subtitle_callback("Héctor", "Bueno, tenemos que irnos, pero ¡suerte!", _rafael_hector_hide_show.bind(false))
	sub_controller.new_subtitle("Tú", "Mierda ¿Que se supone que haré con esto?")
	sub_controller.new_subtitle("","...")
	sub_controller.new_subtitle("", "Tardas al menos 8 horas trabajando en la presentación. Ahora te sientes agotado.")
	_flow_last()

func _on_choose_question_4_flow_2():
	sub_controller.new_subtitle("Tú", "Lo siento, pero tengo mucho trabajo que hacer...")
	sub_controller.new_subtitle("Rafael", "Demonios amigo, de verdad contábamos con que ibas a ayudarnos.")
	sub_controller.new_subtitle("Héctor", "Cielos, supongo que ahora tendrá que encargarse Rafael. ")
	sub_controller.new_subtitle("Rafael", "Si amigo, tendrá que encargarse...")
	sub_controller.new_subtitle("Rafael", "Espera ¿qué? ¡pero si falta la mayor parte de tu trabajo!")
	sub_controller.new_subtitle("Héctor", "¡Pero es la parte que tiene que ver contigo! ademas la tenía que hacer este sujeto y...")
	sub_controller.new_subtitle("Rafael", "No no, eso no, tu tienes que hacer eso porque...")
	sub_controller.new_subtitle_callback("", "Ambos se retiran discutiendo hasta que se pierden de vista entre los muy atareados empleados.", _rafael_hector_hide_show.bind(false))
	sub_controller.new_subtitle("Tú", "Bueno, no era mi problema. Seguro encontraran la manera de lograrlo.")
	_flow_penultimate()
	
	

func _flow_penultimate():
	sub_controller.new_subtitle("Tú", "Supongo que debería ponerme a trabajar ahora.")
	sub_controller.new_subtitle("Tú", "Tardas al menos 8 horas terminando tu trabajo atrasado.")
	_flow_last()
	

func _flow_last():
	sub_controller.new_subtitle("Tú", "Uf, eso fue terrible.")
	sub_controller.new_subtitle("Tú", "Debería volver al baño, quizás descansar un rato... Nisiquiera sé cuando termina mi turno.")
	sub_controller.new_subtitle_callback("Tú", "Regresas al baño rapidamente y cierras la puerta.", _change_scene)
	#sub_controller.new_subtitle("", "Cambio de escena.")

func _change_scene():
	sub_controller.clear_jobs()
	change_scene_flag = true
