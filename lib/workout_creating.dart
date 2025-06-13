import 'package:flutter/material.dart';
import 'package:interval_timer/config.dart';


class WorkoutCreating extends StatefulWidget {
  const WorkoutCreating({super.key});


  @override
  _WorkoutCreating createState() => _WorkoutCreating();

}

class _WorkoutCreating extends State<WorkoutCreating> {
  bool isExerciseSelected = true;
  TextEditingController myController = TextEditingController();


  @override
  void dispose() {
    myController.dispose();
    super.dispose();
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
}