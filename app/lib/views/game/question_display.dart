import 'package:flutter/material.dart';
import 'package:sphinx/models/game.dart';
import 'package:sphinx/models/question.dart';
import 'package:sphinx/views/game/option_button.dart';
import 'package:sphinx/views/game/timer_display.dart';
import 'package:sphinx/views/home/home_page.dart';
import 'package:sphinx/widgets/spaced_column.dart';

class QuestionDisplay extends StatefulWidget {

  final Game game;

  const QuestionDisplay({Key key, this.game}) : super(key: key);

  @override
  _QuestionDisplayState createState() => _QuestionDisplayState();
}

class _QuestionDisplayState extends State<QuestionDisplay> with SingleTickerProviderStateMixin {
  
  AnimationController timerController;

  void resetTimer() {
    this.timerController.reset();
    this.timerController.forward();
  }

  @override
  void initState() {
    super.initState();
  
    this.timerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    );

    this.timerController.forward();

    this.timerController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        this.nextQuestion(delay: 0);
      }
    });
  }
  int questionIndex = 0;

  void nextQuestion({delay = 800}) {
    Future.delayed(Duration(milliseconds: delay),
      () {
        setState(() {
          if (this.questionIndex < this.widget.game.questions.length - 1) {
            this.questionIndex ++;
            this.resetTimer();
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
          }
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    Question question = this.widget.game.questions[this.questionIndex];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: SpacedColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(question.text, style: TextStyle(color: Colors.white, fontSize: 20.0), textAlign: TextAlign.center),
          ),
          ... List.generate(question.options.length, (int index) => OptionButton(
              option: question.options[index], 
              index: index,
              onPressed: () {
                this.nextQuestion();
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              height: 75.0,
              width: 75.0,
              child: TimerDisplay(
                controller: this.timerController,
              )
            ),
          )
        ],
      ),
    );
  }
}