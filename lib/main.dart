import 'package:flutter/material.dart';
import 'todo_repository.dart';
import 'todo_screen.dart';
import 'todo_state.dart';

void main() {
  TodoState st = TodoState(TodoRepository());
  runApp(MyApp(st: st));
}

class MyApp extends StatelessWidget {
  final TodoState st;
  const MyApp({super.key, required this.st});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Делишки',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: TodoScreen(st: st),
    );
  }
}
