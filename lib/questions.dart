import 'package:quiz_app/model/question_model.dart';

List<Question> questions = [
  Question(
    id: '1',
    title:
        "Who developed the Flutter Framework and continues to maintain it today?",
    options: {
      'Facebook': false,
      'Microsoft': false,
      'Google': true,
      'Oracle': false,
    },
  ),
  Question(
    id: '2',
    title: "Which programming language is used to build Flutter applications?",
    options: {
      'Kotlin': false,
      'Dart': true,
      'Java': false,
      'Go': false,
    },
  ),
  Question(
    id: '3',
    title: "A sequence of asynchronous Flutter events is known as a:?",
    options: {
      'Stream': true,
      'Flow': false,
      'Current': false,
      'Series': false,
    },
  )
];
