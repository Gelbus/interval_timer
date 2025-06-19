import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

List<Training>? data = [];

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

  Map<String, dynamic> toJson() => {
    'stepType': stepType,
    'minutes': minutes,
    'seconds': seconds
  };

  factory TrainingElement.fromJson(Map<String, dynamic> json) => TrainingElement(
    stepType: json['stepType'],
    minutes: json['minutes'],
    seconds: json['seconds'],
  );
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

  Map<String, dynamic> toJson() => {
    'name': name,
    'steps': steps.map((step) => step.toJson()).toList(),
  };

  // Создание из Map (из JSON)
  factory Training.fromJson(Map<String, dynamic> json) => Training(
    name: json['name'],
    steps: List<TrainingElement>.from(json['steps'].map((x) => TrainingElement.fromJson(x))),
  );
}


Future<void> saveTrainingsList(List<Training> trainingsList) async {
  final directory = await getExternalStorageDirectory();
  final file = File('${directory?.path}/trainings_list.json');

  // Конвертируем список в JSON (каждый Settings -> toJson())
  final jsonList = trainingsList.map((settings) => settings.toJson()).toList();
  final jsonString = jsonEncode(jsonList);

  await file.writeAsString(jsonString);
  print('Список настроек сохранён: ${file.path}');
}


Future<List<Training>?> loadTrainingsList() async {
  try {
    final directory = await getExternalStorageDirectory();
    print('Нашли папку');
    final file = File('${directory?.path}/trainings_list.json');
    print('Нашли файл');

    if (!await file.exists()) return [];
    print('проверили его на существование');

    final jsonString = await file.readAsString();
    print('Прочитали его в строку');
    final jsonList = jsonDecode(jsonString) as List<dynamic>;

    // Конвертируем каждый элемент списка в Settings
    print('Всё загрузилось');
    return jsonList.map((json) => Training.fromJson(json)).toList();
  } catch (e) {
    print('Ошибка загрузки: $e');
    return [];
  }
}