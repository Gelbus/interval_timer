import 'package:flutter/material.dart';

const Color BGColor = Color(0xff0c1821);
const Color ElementsColor = Color(0xff1B2A41);


class TrainingElement {
  bool stepType;
  int minutes;
  int seconds;

  TrainingElement ({
    required this.stepType,
    required this.minutes,
    required this.seconds
  });
}


class Training
{
  String name = '';
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  List<TrainingElement> steps = [];

  Training ({
    required this.name,
    required this.steps
  }) {
    for (int i = 0; i < steps.length; i++)
      {
        minutes += steps[i].minutes;
        seconds += steps[i].seconds;
      }
    minutes += seconds ~/ 60;
    seconds %= 60;
    hours = minutes ~/ 60;
    minutes %= 60;
  }
}


class Data
{
  List<Training>? data = [];
}
