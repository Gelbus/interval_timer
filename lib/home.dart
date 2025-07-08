import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interval_timer/config.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGColor,
      appBar: appBar(),
      body: Align(
        alignment: Alignment.center,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            workoutsList(),

            const SizedBox(height: 30),

            newWorkoutBtn(context),
          ],
        ),
      )
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Тренировки',
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'base',
          color: Colors.white,
          fontWeight: FontWeight.bold,

        ),
      ),
      backgroundColor: BGColor,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
    );
  }

  Expanded  workoutsList(){
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(left: 20, right: 20),
        itemCount: data!.length,
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) => SizedBox(height: 25,),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(
                context, '/workout',
                arguments: index
              );
            },
            child: Container(
              alignment: Alignment.center,
              width: 340,
              height: 50,
              decoration: BoxDecoration(
                  color: ElementsColor,
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(
                      //color: Colors.blue
                    ),
                    width: 160,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data![index].name,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      //color: Colors.red
                    ),
                    width: 120,
                    height: 40,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${data![index].hours ~/ 10}${data![index].hours % 10}:${data![index].minutes ~/ 10}${data![index].minutes % 10}:${data![index].seconds ~/ 10}${data![index].seconds % 10}',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(width: 10,),
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          data!.remove(data![index]);
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
            )
          );
        },
      ),
    );
  }

  Padding newWorkoutBtn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 40),
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context,
                '/workout_creating').then((_) {
              setState(() {});
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ElementsColor,
            minimumSize: const Size(300, 70),
            maximumSize: const Size(300, 70),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/plus.svg',
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn
                ),
              ),
              SizedBox(width: 10,),
              const Text(
                'Добавить тренировку',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'base'
                ),
              )
            ],
          )
      ),
    );
  }
}