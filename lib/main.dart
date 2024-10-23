import 'package:flutter/material.dart';
import 'package:myclasstwo/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
       /// POINT TO NOTE
      debugShowCheckedModeBanner: false,
      home: Home(),
  );
 }
}

