class Question {
  final String question;
  final List<String> options;
  final int answerIndex; // 0-based index of the correct option

  Question({
    required this.question,
    required this.options,
    required this.answerIndex,
  }) : assert(options.length >= 2),
       assert(answerIndex >= 0 && answerIndex < options.length);
}
