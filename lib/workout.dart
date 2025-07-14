import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interval_timer/config.dart';
import 'package:audioplayers/audioplayers.dart';


class Workout extends StatefulWidget {
  final int currentTraining;
  const Workout({super.key, required this.currentTraining});

  @override
  _Workout createState() => _Workout();

}

class _Workout extends State<Workout> {

  ScrollController _scrollController = ScrollController();

  late List<TrainingElement>? steps;

  int currentStep = -1;

  int generalSeconds = 0;
  int minutes = 0;
  int seconds = 0;

  int generalCurrentSeconds = 0;
  int currentMinutes = 0;
  int currentSeconds = 0;

  bool isPaused = false;
  bool isPrepare = true;

  String activityTypeText = "Подготовка";
  Color activityTypeColor = Colors.yellow;
  Color BGChanger = BGColor;

  Timer? _timer;

  static AudioPlayer player = AudioPlayer();
  AssetSource prepareSoundPath = AssetSource("sounds/prepare_sound.mp3");
  AssetSource startSoundPath = AssetSource("sounds/start_sound.mp3");

  @override
  void initState() {
    super.initState();
    steps = data?[widget.currentTraining].steps;

    generalSeconds =  data![widget.currentTraining].hours * 60 * 60 +
                      data![widget.currentTraining].minutes * 60 +
                      data![widget.currentTraining].seconds +
                      10;
    generalCurrentSeconds = 10;

    minutes = generalSeconds ~/ 60;
    seconds = generalSeconds % 60;

    currentMinutes = generalCurrentSeconds ~/ 60;
    currentSeconds = generalCurrentSeconds % 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerIteration();
    });
    setState(() {});
  }

  void timerIteration() {
    if (!isPaused)
      {
        generalSeconds -= 1;
        generalCurrentSeconds -= 1;

        if (1 <= generalCurrentSeconds && generalCurrentSeconds <= 3)
        {
          player.play(prepareSoundPath);
        }
        else if (generalCurrentSeconds == 0)
        {
          player.play(startSoundPath);
        }

        if (isPrepare)
        {
          isPrepare = false;
        }
        if (generalCurrentSeconds == 0)
        {
          currentStep += 1;

          if (currentStep == steps?.length)
          {
            _timer?.cancel();
          }
          else
          {
            generalCurrentSeconds = steps![currentStep].minutes * 60 +
                steps![currentStep].seconds;
            activityTypeText = steps![currentStep].stepType ? "Работа": "Отдых";
            activityTypeColor = steps![currentStep].stepType ? Colors.pink: Colors.green;
            BGChanger = steps![currentStep].stepType ? Colors.pink: Colors.green;

          }
        }

        minutes = generalSeconds ~/ 60;
        seconds = generalSeconds % 60;

        currentMinutes = generalCurrentSeconds ~/ 60;
        currentSeconds = generalCurrentSeconds % 60;
      }

    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel(); // ОБЯЗАТЕЛЬНО отменяем таймер при удалении виджета
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGColor,
      appBar: appBar(),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            _generalTimer(),
            SizedBox(height: 20),
            _stepTimer(),
            _activityType(),
            SizedBox(height: 20),
            _stepsList(),

            SizedBox(height: 10,),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: BGChanger, width: 40),
                ),
            )
            )
          ],
        ),
      ),
    );
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
        _scrollController.position.extentTotal,
        duration: Duration(seconds: 1),
        curve: Curves.easeOut);
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        data![widget.currentTraining].name,
        style: TextStyle(
            fontSize: 30,
            fontFamily: 'base',
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: BGChanger,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isPaused = !isPaused;
            });
          },
          icon: Icon(
            !isPaused? Icons.pause: Icons.not_started_outlined,
            color: Colors.white,
            size: 40,
          ),
        )
      ],
    );
  }

  Text _generalTimer()
  {
    return Text(
      "${minutes ~/ 10}${minutes % 10} : ${seconds ~/ 10}${seconds % 10}",
      style: TextStyle(
          fontSize: 30,
          fontFamily: 'base',
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Container _stepTimer()
  {
    return Container(
      width: 300,
      height: 140,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: BGChanger,
          width: 20
        ),
        borderRadius: BorderRadius.circular(50)
      ),
      child:Text(
        "${currentMinutes ~/ 10}${currentMinutes % 10} : ${currentSeconds ~/ 10}${currentSeconds % 10}",
        style: TextStyle(
          fontSize: 80,
          fontFamily: 'base',
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      )
    );
  }

  Text _activityType()
  {
    return Text(
      activityTypeText,
      style: TextStyle(
          fontSize: 50,
          fontFamily: 'base',
          color: activityTypeColor,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Expanded  _stepsList(){
    return Expanded(
      // child: Container(
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(color: BGChanger, width: 40),
        //   ),
        // ),
        child: ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          itemCount: steps!.length,
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => SizedBox(height: 10,),
          itemBuilder: (context, index) {
            return Container(
                alignment: Alignment.center,
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    color: ElementsColor,
                    borderRadius: BorderRadius.circular(16)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        steps![index].stepType ? 'Работа': 'Отдых',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 40,
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${steps![index].minutes~/10}${steps![index].minutes%10} : ${steps![index].seconds~/10}${steps![index].seconds%10}',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
            );
          },
        ),
      );
    // );
  }
}