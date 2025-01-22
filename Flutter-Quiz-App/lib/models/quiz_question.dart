class QuizQuestion {
  const QuizQuestion(this.text, this.answers);
  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(
        answers); // final is allowed because we are just shuffling the list not reassigning them
    shuffledList.shuffle();
    return shuffledList;
  }
}
