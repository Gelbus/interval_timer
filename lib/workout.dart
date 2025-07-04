import 'package:flutter/material.dart';
import 'package:interval_timer/config.dart';


class Workout extends StatefulWidget {
  final int currentTraining;
  const Workout({super.key, required this.currentTraining});

  @override
  _Workout createState() => _Workout();


}

class _Workout extends State<Workout> {

  ScrollController _scrollController = ScrollController();

  late List<TrainingElement>? steps;

  int currentStep = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    steps = data?[widget.currentTraining].steps;
    minutes = data![widget.currentTraining].hours * 60 + data![widget.currentTraining].minutes;
    seconds = data![widget.currentTraining].seconds;
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
      title: const Text(
        '',
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

  Text _stepTimer()
  {
    return Text(
      "${minutes ~/ 10}${minutes % 10} : ${seconds ~/ 10}${seconds % 10}",
      style: TextStyle(
          fontSize: 80,
          fontFamily: 'base',
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Text _activityType()
  {
    return Text(
      "Отдых",
      style: TextStyle(
          fontSize: 50,
          fontFamily: 'base',
          color: Colors.green,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Expanded  _stepsList(){
    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.only(left: 20, right: 20),
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
                      steps![index].stepType ? '${index + 1} Работа': '${index + 1} Отдых',
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

                  Container(
                    width: 80,
                    height: 40,
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          steps?.remove(steps?[index]);
                        });
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  )
                ],
              )
          );
        },
      ),
    );
  }
}