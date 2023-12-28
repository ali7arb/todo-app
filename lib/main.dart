import 'package:TodoApp/sqflite/layout_home.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'core/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutHome(),
    );
  }
}
