import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:gemini_gdsc/apikey.dart';
import 'package:http/http.dart' as http;

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  //users
  ChatUser myself = ChatUser(id: '1', firstName: 'Deva');
  ChatUser gemini = ChatUser(id: '2', firstName: 'Gemini');

//message list
  List<ChatMessage> messages = <ChatMessage>[];
  List<ChatUser> _typing = <ChatUser>[];

  final url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${GeminiApiKey.apiKey}';

  final header = {'Content-Type': 'application/json'};

  getdata(ChatMessage m) async {
    _typing.add(gemini);
    messages.insert(0, m);
    setState(() {});

    //----------api used------------------------

    try {
      var query = {
        "contents": [
          {
            "parts": [
              {"text": m.text}
            ]
          }
        ]
      };

      final response = await http
          .post(
            Uri.parse(url),
            headers: header,
            body: jsonEncode(query),
          )
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result['candidates'][0]['content']['parts'][0]['text']);

        ChatMessage data = ChatMessage(
            text: result['candidates'][0]['content']['parts'][0]['text'],
            user: gemini,
            createdAt: DateTime.now());

        messages.insert(0, data);
        setState(() {});
      }
    } catch (e) {
      print('Error block $e');
    }

    //----------without api usage----------------------------------

    // await Future.delayed(Duration(seconds: 2));

    // ChatMessage data = ChatMessage(
    //     text: 'hello i am devangana', user: gemini, createdAt: DateTime.now());

    // messages.insert(0, data);
    _typing.remove(gemini);
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Talk',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: DashChat(
        currentUser: myself,
        typingUsers: _typing,
        onSend: (ChatMessage m) {
          getdata(m);
        },
        messages: messages,
        inputOptions: const InputOptions(
            alwaysShowSend: true,
            cursorStyle: CursorStyle(color: Colors.black)),
        messageOptions: MessageOptions(
            currentUserContainerColor: Colors.grey,
            avatarBuilder: yourAvatarBuilder),
      ),
    );
  }

  Widget yourAvatarBuilder(
      ChatUser user, Function? onAvatarTap, Function? onAvatarLongPress) {
    return Center(
      child: Image.asset(
        'assets/g.png',
        height: 30,
        width: 30,
      ),
    );
  }
}
