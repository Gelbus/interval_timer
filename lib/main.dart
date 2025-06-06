import 'package:flutter/material.dart';

import 'package:interval_timer/home.dart';
import 'package:interval_timer/workout.dart';
import 'package:interval_timer/workout_creating.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'base'),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/workout_creating': (context) => const WorkoutCreating(),
        '/workout': (context) => const Workout(),
      },
    );
  }
}





