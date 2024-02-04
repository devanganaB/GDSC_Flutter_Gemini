import 'package:flutter/material.dart';
import 'package:gemini_gdsc/textonly.dart';
import 'package:gemini_gdsc/textwithimage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gemini gdsc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      // const BotScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple[100],
            title: const Text(
              'Gemini',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontSize: 25),
            ),
            centerTitle: true,
            bottom: const TabBar(
                tabs: [Tab(text: "Text Only"), Tab(text: "Text & Image")]),
          ),
          body: const TabBarView(children: [TextOnly(), TextwithImage()]),
        ));
  }
}
