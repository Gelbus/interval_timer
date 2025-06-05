import 'package:flutter/material.dart';

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

            SizedBox(height: 40,),

            Container(
              width: 350,
              height: 500,
              child: ListView.separated(
                itemCount: 15,
                scrollDirection: Axis.vertical,
                // padding: EdgeInsets.only(
                //   left: 10,
                //   right: 10
                // ),
                separatorBuilder: (context, index) => SizedBox(height: 25,),
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    width: 350,
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
                              color: Colors.blue
                          ),
                          width: 150,
                          height: 40,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'тренировка ' + index.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red
                          ),
                          width: 150,
                          height: 40,
                          alignment: Alignment.centerRight,
                          child: Text(
                            '00:00:00',
                            style: TextStyle(
                              fontSize: 30,
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


            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ElementsColor,
                    minimumSize: const Size(300, 70),
                    maximumSize: const Size(300, 70),
                  ),
                  child: const Text(
                    'Добавить тренировку',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
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
            fontSize: 40,
            fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: BGColor,

      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
    );
  }
}