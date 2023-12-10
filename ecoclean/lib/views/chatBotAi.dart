import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/chatAPI.dart';


class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});
  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {

  //iniciar conexión con OpenAI
  final _openAI = OpenAI.instance.build(
    //API key de conexión
    token: OPENAI_API_KEY,
    //Tiempo de respuesta del mensaje
    baseOption: HttpSetup(receiveTimeout:const Duration(seconds: 5),),
    enableLog: true,);

  //Datos del usuario
  final ChatUser _currentUser = ChatUser(id: '1', firstName: "Eco", lastName: "Clean");
  //Datos del chatbot
  final ChatUser _gptChatUser = ChatUser(id: '2', firstName: 'ChatBot', lastName: 'EcoClean');

  //Lista de mensajes
  List<ChatMessage> _messages = <ChatMessage>[];
  //Identificador de respuesta
  List<ChatUser> _isTyping = <ChatUser>[];

  //Inicializador de procesos
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

  //Construir de la vista
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar identificador de ventana
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("CatBot EcoClean", style: TextStyle(color: Colors.white),),
        //Icono de regreso
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white70,),
          //Retornar a la vista anterior
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      //Constructor del chat
      body: DashChat(
        //Definir Usuario y ChatBot
          currentUser: _currentUser,
          typingUsers: _isTyping,
          //Decoración de mensajes
          messageOptions: const MessageOptions(
            currentUserContainerColor: Colors.green,
            containerColor: Colors.black12,
            textColor: Colors.black,
            currentUserTextColor: Colors.white
          ),
          //Recibir mensaje enviado
          onSend: (ChatMessage m){
            //Definir respuesta
            getChatResponse(m);
          },
          //Identificador de mensajes
          messages: _messages)
    );
  }
  //Conexion con OpenAI
  Future<void> getChatResponse(ChatMessage m) async{
    setState(() {
      //Enviar mensajes
      _messages.insert(0, m);
      //Identificador de respuesta
      _isTyping.add(_gptChatUser);
    });
    //Guardar historial de mensajes en la ventana
    List<Messages> _messageHistory = _messages.reversed.map((m) {
      //Si el mensaje es enviado por el usuario
      if (m.user == _currentUser) {
        //Enviar mensaje a OpenAI
        return Messages(role: Role.user, content: m.text);
      }else {
        //Si no, mostrar respuesta de OpenAI
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    //Definir parametros de OpenAI
    final request = ChatCompleteText(model: GptTurbo0301ChatModel(), messages: _messageHistory, maxToken: 200);
    //Esperar la respuesta de OpenAI
    final response = await _openAI.onChatCompletion(request: request);
    //Decoración de mensajes
    for (var element in response!.choices){
      if(element.message != null) {
        setState(() {
          //Mostrar hora y fecha antes de iniciar la conversación
          _messages.insert(0, ChatMessage(user: _gptChatUser, createdAt: DateTime.now(), text: element.message!.content));
        });
      }
    }
    //Si realiza una respuesta, ocultar el identificador de respuesta
    setState(() {
      _isTyping.remove(_gptChatUser);
    });
  }
}
