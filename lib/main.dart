import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

// MyApp Stateless Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Planner Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Modern Flutter design
      ),
      // Flutter Routes: Defining the initial navigation path
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
      },
    );
  }
}