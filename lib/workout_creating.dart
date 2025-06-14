import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interval_timer/config.dart';
import 'package:numberpicker/numberpicker.dart';


class WorkoutCreating extends StatefulWidget {
  const WorkoutCreating({super.key});


  @override
  _WorkoutCreating createState() => _WorkoutCreating();

}

class _WorkoutCreating extends State<WorkoutCreating> {
  TextEditingController myController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  bool isExerciseSelected = true;
  int seconds = 1;
  int minutes = 0;

  List<TrainingElement> steps = [];




  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
        _scrollController.position.extentTotal,
        duration: Duration(seconds: 1),
        curve: Curves.easeOut);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGColor,
      appBar: appBar(),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            _textField(),

            SizedBox(height: 10,),

            _choiceSlider(),

            SizedBox(height: 20,),

            _timeChanger(),

            SizedBox(height: 20,),

            _stepsList(),

            SizedBox(height: 20,),

            _addStep(),
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
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            size: 35
          ),
          onPressed: () {
            print('Добавить тренировку');
            Navigator.pushNamed(context, '/');
          },
        ),
      ],
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: BGColor,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
    );
  }

  Container _textField() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: myController,
        decoration: InputDecoration(
          hintText: 'Введите название тренировки',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),

          ), // граница поля
          suffixIcon: IconButton( // иконка после текста
            icon: Icon(Icons.clear),
            onPressed: () => myController.clear(),
          ),
          filled: true, // заливка фона
          fillColor: ElementsColor, // цвет фона
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done, // действие кнопки "Готово"
        style: TextStyle( // стиль текста
            fontSize: 16,
            color: Colors.white,
            fontFamily: 'base'
        ),
        textAlign: TextAlign.start, // выравнивание текста
        maxLength: 14, // максимальное количество символов
        cursorColor: Colors.blue, // цвет курсора
        cursorWidth: 2.0, // ширина курсора
        cursorHeight: 20.0, // высота курсора
        onChanged: (text) { // обработчик изменения текста
          print('Текст изменился: $text');
        },
        onSubmitted: (text) { // обработчик нажатия "Готово"
          print('Отправлено: $text');
        },
      ),
    );
  }

  Container _choiceSlider() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff1B2A41),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAnimatedButton(
            text: "Работа",
            isSelected: isExerciseSelected,
            onTap: () {
              setState(() {
                isExerciseSelected = true;
              });
            },
          ),
          _buildAnimatedButton(
            text: "Отдых",
            isSelected: !isExerciseSelected,
            onTap: () {
              setState(() {
                isExerciseSelected = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: isSelected ? 160 : 120,
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff324A5F) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 20,
            fontFamily: 'base'
          ),
        ),
      ),
    );
  }

  Container _timeChanger() {
    return  Container(
        decoration: BoxDecoration(
          // color: Colors.red
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                minValue: 0,
                maxValue: 59,
                value: minutes,
                zeroPad: true,
                infiniteLoop: true,

                itemHeight: 70,
                itemCount: 3,
                onChanged: (value) {
                  setState(() {
                    minutes = value;
                  });
                },
                selectedTextStyle: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontFamily: 'base'
                ),
                textStyle: TextStyle(
                    fontSize: 40,
                    color: Colors.grey,
                    fontFamily: 'base'
                ),
              ),

              Text(
                ':',
                style: TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontFamily: 'base'
                ),
              ),

              NumberPicker(
                minValue: 1,
                maxValue: 59,
                value: seconds,
                zeroPad: true,
                infiniteLoop: true,
                itemHeight: 70,
                itemCount: 3,
                onChanged: (value) {
                  setState(() {
                    seconds = value;
                  });
                },
                selectedTextStyle: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontFamily: 'base'
                ),
                textStyle: TextStyle(
                    fontSize: 40,
                    color: Colors.grey,
                    fontFamily: 'base'
                ),
                // decoration: BoxDecoration(
                //   border: Border(
                //     top: BorderSide(
                //       color: Colors.white,
                //       width: 1
                //     ),
                //     bottom: BorderSide(
                //       color: Colors.white,
                //       width: 1
                //     )
                //   ),
                // )

              ),
            ]
        )
    );
  }

  Expanded  _stepsList(){
    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.only(left: 20, right: 20),
        itemCount: steps.length,
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
                      steps[index].stepType ? '${index + 1} Работа': '${index + 1} Отдых',
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
                      '${steps[index].minutes~/10}${steps[index].minutes%10} : ${steps[index].seconds~/10}${steps[index].seconds%10}',
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
                          steps.remove(steps[index]);
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

  Padding _addStep() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            steps.add(TrainingElement(stepType: isExerciseSelected, minutes: minutes, seconds: seconds));
          });
          _scrollToEnd();
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

            SizedBox(width: 10),

            const Text(
              'Добавить шаг',
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