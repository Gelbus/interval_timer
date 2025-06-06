import 'package:flutter/material.dart';

class WorkoutCreating extends StatelessWidget {
  const WorkoutCreating({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Второй экран'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Это второй экран приложения. Здесь может быть какая-то дополнительная информация или функционал.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Вернуться в главное меню'),
            ),
          ],
        ),
      ),
    );
  }
}