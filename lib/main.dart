import 'package:flutter/material.dart';

import 'package:interval_timer/home.dart';
import 'package:interval_timer/workout.dart';
import 'package:interval_timer/workout_creating.dart';
import 'package:interval_timer/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  data = await loadTrainingsList();
  print('Приложение стартовало');
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
        '/workout_creating': (context) => WorkoutCreating(),
        '/workout': (context) {
          final currentTraining = ModalRoute.of(context)!.settings.arguments as int;
          return Workout(currentTraining: currentTraining);
        },
      },
    );
  }
}





