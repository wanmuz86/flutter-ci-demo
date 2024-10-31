import 'package:flutter/material.dart';
import 'dart:isolate';
import 'package:flutter/foundation.dart'; // For compute()
import 'config/environment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolates and Concurrency Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _result = 'Press the button to start the task';


  // Factorial computation
  static int _calculateFactorial(int n) => n == 1 ? 1 : n * _calculateFactorial(n - 1);


  // Function to start the isolate
  Future<void> _performHeavyTaskWithCompute() async {
    final result = await compute(_calculateFactorial, 20);
    setState(() {
      _result = 'The factorial of 20 is: $result';
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Isolates and Concurrency'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _result,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text('API URL: ${EnvironmentConfig.apiUrl}'),
            ElevatedButton(
              onPressed: _performHeavyTaskWithCompute,
              child: Text('Start Heavy Task'),
            ),
          ],
        ),
      ),
    );
  }
}
