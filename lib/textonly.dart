import 'package:flutter/material.dart';
import 'package:gemini_gdsc/apikey.dart';
import 'package:google_gemini/google_gemini.dart';

class TextOnly extends StatefulWidget {
  const TextOnly({super.key});

  @override
  State<TextOnly> createState() => _TextOnlyState();
}

class _TextOnlyState extends State<TextOnly> {
  List textChat = []; //stores messages
  bool loading = false; //for circular loader display

  final TextEditingController _textController =
      TextEditingController(); //input text(query)
  final ScrollController _scroll =
      ScrollController(); //scrolling to the latest msg

  final gemini = GoogleGemini(apiKey: GeminiApiKey.apiKey);

  // Text only input
  // passing queries through this function
  void queryText({required String query}) {
    //sets the state of loader->true
    //adds query to textChat list based on role
    setState(() {
      loading = true;
      textChat.add({
        "role": "User",
        "text": query,
      });
      _textController.clear();
    });
    scrollToEnd();

    //using the gemini instance to call function
    //query passed as parameter and response taken as value
    gemini.generateFromText(query).then((value) {
      //sets state of loader->false ie loader wont be displayed any more
      //adds respone value to textChat list based on role(gemini)
      setState(() {
        loading = false;
        textChat.add({
          "role": "Gemini",
          "text": value.text,
        });
      });
      scrollToEnd();
    }).onError((error, stackTrace) {
      //loader->false; it will stop showing up on screen
      //error will added to chat from Gemini's side
      loading = false;
      textChat.add({
        "role": "Gemini",
        "text": error.toString(),
      });
      scrollToEnd();
    });
  }

  //function to bring the chat screen to latest text msg
  void scrollToEnd() {
    _scroll.jumpTo(_scroll.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: ListView.builder(
                controller: _scroll,
                itemCount: textChat
                    .length, //count of tiles == number of items in textChat List
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(textChat[index]["role"]
                          .substring(0, 1)), //first letter of role as Avatar
                    ),
                    title: Text(textChat[index]["role"]), //username=>role
                    subtitle: Text(textChat[index]["text"]), //chat=>text
                  );
                })),
        Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey)),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      hintText: "Type your Prompt..",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      fillColor: Colors.transparent),
                  keyboardType: TextInputType.multiline,
                ),
              ),
              IconButton(
                  onPressed: () {
                    queryText(query: _textController.text);
                  },
                  icon: loading
                      ? const CircularProgressIndicator()
                      : const Icon(
                          Icons.send,
                          color: Colors.deepPurple,
                        ))
            ],
          ),
        )
      ]),
    );
  }
}
