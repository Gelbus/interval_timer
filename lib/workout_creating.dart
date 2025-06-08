import 'package:flutter/material.dart';
import 'package:interval_timer/config.dart';


class WorkoutCreating extends StatefulWidget {
  const WorkoutCreating({super.key});

  @override
  _WorkoutCreating createState() => _WorkoutCreating();
}

class _WorkoutCreating extends State<WorkoutCreating> {
  List<bool> isSelected = [true, false]; // Состояние переключателя

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGColor,
      appBar: appBar(),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [

            SizedBox(height: 30,),

            ToggleButtons(
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                  });
                },
                borderRadius: BorderRadius.all(Radius.circular(30)),
                selectedColor: Colors.red,
                fillColor: Colors.green,
                color: Colors.blue,
                borderColor: Colors.black,
                selectedBorderColor: Colors.black,
                children:
                [
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 50, top: 10, bottom: 10),
                    child: Text(
                      'Работа',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'base',
                        fontSize: 25
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 50, top: 10, bottom: 10),
                    child: Text(
                      'Отдых',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'base',
                        fontSize: 25
                      ),
                    ),
                  )
                ]
            )
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Новая тренировка',
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'base',
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: BGColor,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
    );
  }
}