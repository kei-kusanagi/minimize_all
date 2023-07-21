import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentDateTime;

  @override
  Widget build(BuildContext context) {
    DateTime currentDateTime = DateTime.now();
    String formattedTime = DateFormat.Hm().format(currentDateTime);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current Time is ${formattedTime!}'),
            ElevatedButton(
              onPressed: () {
                _minimizeAllWindows();
              },
              child: Text('Minimizar todo'),
            )
          ],
        ),
      ),
    );
  }
}

void _minimizeAllWindows() async {
  if (Platform.isWindows) {
    final result = await Process.run('powershell', [
      '-command',
      '(New-Object -ComObject Shell.Application).MinimizeAll()'
    ]);
  } else if (Platform.isMacOS) {
    final result = await Process.run('osascript', [
      '-e',
      'tell application "System Events"\nset allApps to every application process\nrepeat with thisApp in allApps\nset visible of thisApp to false\nend repeat\nend tell',
    ]);
  }
}
