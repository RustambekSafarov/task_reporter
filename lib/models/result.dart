class Result {
  Map student;
  List tasks;
  int? rightAnswers;
  Result({required this.student, required this.tasks, this.rightAnswers});

  factory Result.getResult(Map data) {
    int _rightAnswerss = 0;
    for (Map i in data['tasks']) {
      if (i['is_correct']) {
        _rightAnswerss++;
      }
    }
    return Result(
      student: data['student'],
      tasks: data['tasks'],
      rightAnswers: _rightAnswerss,
    );
  }
}
