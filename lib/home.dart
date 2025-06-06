import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color BGColor = Color(0xff0c1821);
const Color ElementsColor = Color(0xff1B2A41);

class Home extends StatelessWidget {
  const Home({super.key});

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

            Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  itemCount: 15,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) => SizedBox(height: 25,),
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
                            decoration: BoxDecoration(
                                //color: Colors.blue
                            ),
                            width: 170,
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Тренировка $index',
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
                            width: 130,
                            height: 40,
                            alignment: Alignment.centerRight,
                            child: Text(
                              '00:00:00',
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
              ),

            const SizedBox(height: 30),


            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/workout_creating');
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
            )
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
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontFamily: 'base'
        ),
      ),
      backgroundColor: BGColor,

      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
    );
  }
}