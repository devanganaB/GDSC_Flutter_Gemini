import 'dart:async';

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
        // brightness: Brightness.dark,
        // colorScheme: ColorScheme.dark(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Splashscreen(),
      // const HomePage(),
      // const BotScreen(),
    );
  }
}

//------------splashscreen--------------------
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
          ),
          Center(
            child: Image.asset(
              // 'assets/gemini_splash.jpg',
              'assets/Google-Gemini.png',
              height: 500,
              width: 500,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}

//----------------home-----------------------

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
