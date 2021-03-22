import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quiz = new QuizBrain();

void main() => runApp(Quizz());

class Quizz extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Quizz'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizpage(),
          ),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List<Icon> scoreKeeper = [];
  //List<String> question=['Your name is gomathi.','Are you coming from Thirubuvanai','Are you completed Bacherlor degeree'];
  //int questionNumber=0;
  //List<bool> answer=[true,false,true];
  /*List<Question> questionBank=[
    Question(q:'Your name is gomathi.',a:true),Question(q:'Are you coming from Thirubuvanai.',a:false),Question(q:'Are you completed Bacherlor degeree.',a:true)
  ];*/
  void checkanswer(bool userpickedanswer) {
    bool correct = quiz.getAnswer();

    setState(() {
      quiz.nextQuestion();
      if (quiz.isFinished() == true) {
        print(true);
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of quiz',
        ).show();

        quiz.reset();
        scoreKeeper = [];
      } else if (userpickedanswer == correct) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(quiz.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      )),
                ),
              )),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    checkanswer(true);

                  },
                  child: Text(
                    'True',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                )),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: () {
                    checkanswer(false);
                  },
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: Row(children: scoreKeeper),
          ),
        ]);
  }
}
