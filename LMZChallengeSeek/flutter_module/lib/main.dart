import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const platform = MethodChannel("com.lmarca.channel");
  String receivedText = "Waiting for message..";

  @override
  void initState() {
    super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    platform.setMethodCallHandler((call) async {
      if (call.method == "sendText") {
        setState(() {
          receivedText = call.arguments ?? "No data received";
        });
      }
    });
  });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter MethodChannel")),
        body: Center(child: Text(receivedText, style: TextStyle(fontSize: 24))),
      ),
    );
  }
}
