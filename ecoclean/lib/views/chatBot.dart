import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});
  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  // Datos del usuario
  final ChatUser _currentUser = ChatUser(id: '1', firstName: "Eco", lastName: "Clean");
  // Datos del chatbot
  final ChatUser _gptChatUser = ChatUser(id: '2', firstName: 'ChatBot', lastName: 'EcoClean');

  // Lista de mensajes
  final List<ChatMessage> _messages = <ChatMessage>[];
  // Identificador de respuesta
  final List<ChatUser> _isTyping = <ChatUser>[];

  // Inicializador de procesos
  @override
  void initState() {
    super.initState();
    // Mostrar un mensaje de bienvenida cuando se inicia el chat
    _showWelcomeMessage();
  }

  // Método para mostrar el mensaje de bienvenida
  void _showWelcomeMessage() {
    final welcomeMessage = ChatMessage(
      user: _gptChatUser,
      createdAt: DateTime.now(),
      text: "Bienvenido al ChatBot de EcoClean Bogotá, estaré aquí para responder todas tus dudas",
    );

    setState(() {
      _messages.insert(0, welcomeMessage);
    });
  }

  // Generar respuesta del chatbot
  String? _generateResponse(String text) {
  text = text.toLowerCase();
  
  // Saludos
  if (text.contains("hola") || text.contains("buenas")) {
    return "¡Hola! ¿Cómo estás? Estoy aquí para ayudarte con cualquier pregunta sobre reciclaje y disposición de residuos en Bogotá.";
  } else if (text.contains("buenos días")) {
    return "¡Buenos días! ¿En qué puedo ayudarte hoy?";
  } else if (text.contains("buenas tardes")) {
    return "¡Buenas tardes! ¿Qué te gustaría saber sobre reciclaje y disposición de residuos?";
  } else if (text.contains("buenas noches")) {
    return "¡Buenas noches! ¿Tienes alguna pregunta sobre reciclaje o disposición de residuos?";

  // Reciclaje en Colombia
  } else if (text.contains("reciclar")) {
    return "En Colombia, es importante separar los residuos en orgánicos, reciclables y no reciclables. Asegúrate de limpiar y secar los materiales reciclables antes de desecharlos.";
  } else if (text.contains("papel")) {
    return "El papel es reciclable. Asegúrate de que esté limpio y seco antes de colocarlo en el contenedor de reciclaje.";
  } else if (text.contains("plástico")||text.contains("plastico")) {
    return "Los plásticos con los números 1 y 2 son reciclables. Lávalos bien antes de reciclarlos.";
  } else if (text.contains("vidrio")) {
    return "El vidrio es 100% reciclable. Separa los diferentes colores de vidrio para un mejor reciclaje.";
  } else if (text.contains("metales")) {
    return "Las latas de aluminio y otros metales son reciclables. Asegúrate de enjuagarlas antes de reciclar.";
  } else if (text.contains("orgánicos")||text.contains("organicos")) {
    return "Los desechos orgánicos como restos de comida y hojas se pueden compostar. No los mezcles con otros reciclables.";
  } else if (text.contains("electrónicos")||text.contains("electronicos")) {
    return "Los desechos electrónicos deben llevarse a puntos de reciclaje especializados. No los deseches con la basura común.";
  } else if (text.contains("pilas")) {
    return "Las pilas y baterías deben reciclarse en puntos de recolección específicos debido a sus componentes tóxicos.";
  } else if (text.contains("consejos")) {
    return "Consejo: Reduce, Reutiliza y Recicla. Intenta comprar productos con menos empaque y reutiliza lo que puedas antes de reciclar.";
  } else if (text.contains("residuos peligrosos")) {
    return "Los residuos peligrosos como pinturas, solventes y productos químicos deben ser llevados a puntos de recolección especializados.";
  } else if (text.contains("aceite de cocina")) {
    return "El aceite de cocina usado no debe ser vertido por el desagüe. Recolecta el aceite usado en un recipiente y llévalo a un punto de recolección especializado.";
  } else if (text.contains("ropa y textiles")) {
    return "La ropa y textiles en buen estado pueden ser donados. Los textiles en mal estado pueden ser llevados a puntos de reciclaje especializados.";
  } else if (text.contains("compostaje")) {
    return "El compostaje es una excelente manera de manejar residuos orgánicos. Los restos de comida y otros desechos orgánicos se descomponen y se convierten en abono.";
  } else if (text.contains("cartón")||text.contains("carton")) {
    return "El cartón es reciclable. Asegúrate de que esté limpio y seco, y desármalo antes de colocarlo en el contenedor de reciclaje.";
  } else if(text.contains("residuos")){
    return "En muchos lugares, se espera que las personas separen sus residuos en diferentes categorías antes de que sean recogidos por los servicios municipales. Las categorías más comunes son: \nOrgánicos: Restos de comida, cáscaras de frutas y verduras, y otros desechos biodegradables. Estos residuos a menudo se destinan a compostaje. \nReciclables: Incluyen papel, cartón, plástico, vidrio y metales. Estos materiales son llevados a plantas de reciclaje para ser procesados y reutilizados.\nNo reciclables: Desechos que no se pueden reciclar ni compostar, como pañales, colillas de cigarrillos, y ciertos tipos de plásticos.\nResiduos peligrosos: Pilas, baterías, productos electrónicos, pinturas, productos químicos, etc. Estos deben manejarse con cuidado debido a su potencial de daño ambiental y a la salud humana.";
  } else if(text.contains("tapas")){
    return "Las tapas de botellas son reciclables. Asegúrate de que estén limpias y secas antes de colocarlas en el contenedor de reciclaje.";
  } else if(text.contains("bolsas")){
    return "Las bolsas plasticas son reciclables. Asegúrate de que estén limpias y secas antes de colocarlas en el contenedor de reciclaje.";
  }

  // En qué caneca va cada tipo de residuo
  else if (text.contains("caneca") && text.contains("papel")  || text.contains("basurero") && text.contains("papel") || text.contains("contenedor") && text.contains("papel")) {
    return "El papel va en la caneca de reciclaje de color azul.";
  } else if (text.contains("caneca") && text.contains("plástico") || text.contains("basurero") && text.contains("plástico") || text.contains("contenedor") && text.contains("plástico")) {
    return "El plástico reciclable va en la caneca de reciclaje de color blanco.";
  } else if (text.contains("caneca") && text.contains("vidrio") || text.contains("basurero") && text.contains("vidrio") || text.contains("contenedor") && text.contains("vidrio")) {
    return "El vidrio va en la caneca de reciclaje de color verde.";
  } else if (text.contains("caneca") && text.contains("metales")  || text.contains("basurero") && text.contains("metales") || text.contains("contenedor") && text.contains("metales")) {
    return "Los metales reciclables van en la caneca de reciclaje de color amarillo.";
  } else if (text.contains("caneca") && text.contains("orgánicos") || text.contains("basurero") && text.contains("orgánicos") || text.contains("contenedor") && text.contains("orgánicos")) {
    return "Los residuos orgánicos van en la caneca de color marrón o en el compostador si tienes uno.";
  } else if (text.contains("caneca") && text.contains("basura") || text.contains("basurero") && text.contains("basura") || text.contains("no reciclables") || text.contains("contenedor") && text.contains("basura")) {
    return "Los residuos no reciclables van en la caneca de color negro.";
  }else if (text.contains("caneca") && text.contains("tapas") || text.contains("basurero") && text.contains("tapas") || text.contains("contenedor") && text.contains("tapas")) {
    return "Los residuos plásticos reciclables van en la caneca de color blanco.";
  }

  // Qué bolsa usar para cada tipo de residuo
  else if (text.contains("bolsa") && text.contains("papel")) {
    return "El papel debe ir en una bolsa blanca para reciclables.";
  } else if (text.contains("bolsa") && text.contains("plástico") || text.contains("bolsa") &&  text.contains("plastico")) {
    return "El plástico reciclable debe ir en una bolsa blanca para reciclables.";
  } else if (text.contains("bolsa") && text.contains("vidrio")) {
    return "El vidrio debe ir en una bolsa blanca para reciclables.";
  } else if (text.contains("bolsa") && text.contains("metales")) {
    return "Los metales reciclables deben ir en una bolsa blanca para reciclables.";
  } else if (text.contains("bolsa") && text.contains("orgánicos") || text.contains("bolsa") && text.contains("organicos")) {
    return "Los residuos orgánicos deben ir en una bolsa verde.";
  } else if (text.contains("bolsa") && (text.contains("basura") || text.contains("no reciclables"))) {
    return "Los residuos no reciclables deben ir en una bolsa negra.";
  } else if (text.contains("bolsa") && text.contains("cárton") || text.contains("bolsa") &&  text.contains("carton")){
    return  "El cárton debe ir en una bolsa blanca para reciclables.";
  }else if (text.contains("bolsa") && text.contains("bolsas")) {
    return "Las bolsas plasticas debe ir en una bolsa blanca para reciclables.";
  }
  

  return "Lo siento, no entiendo tu pregunta. ¿Podrías reformularla?";
}

  // Construir de la vista
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar identificador de ventana
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "ChatBot EcoClean",
          style: TextStyle(color: Colors.white),
        ),
        // Icono de regreso
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white70,
          ),
          // Retornar a la vista anterior
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      // Constructor del chat
      body: DashChat(
        // Definir Usuario y ChatBot
        currentUser: _currentUser,
        typingUsers: _isTyping,
        // Decoración de mensajes
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.green,
          containerColor: Colors.black12,
          textColor: Colors.black,
          currentUserTextColor: Colors.white,
        ),
        // Recibir mensaje enviado
        onSend: (ChatMessage m) {
          // Definir respuesta
          _handleUserMessage(m);
        },
        // Identificador de mensajes
        messages: _messages,
      ),
    );
  }

  // Manejo de mensajes enviados por el usuario
  void _handleUserMessage(ChatMessage m) {
    setState(() {
      // Enviar mensajes
      _messages.insert(0, m);
      // Simular respuesta del chatbot
      _isTyping.add(_gptChatUser);
    });

    // Simular un tiempo de espera para la respuesta del chatbot
    Future.delayed(const Duration(seconds: 1), () {
      String? responseText = _generateResponse(m.text);
      final botResponse = ChatMessage(
        user: _gptChatUser,
        createdAt: DateTime.now(),
        text: responseText ?? "Lo siento, no entiendo tu pregunta. ¿Podrías reformularla?",
      );

      setState(() {
        _messages.insert(0, botResponse);
        _isTyping.remove(_gptChatUser);
      });
    });
  }
}
