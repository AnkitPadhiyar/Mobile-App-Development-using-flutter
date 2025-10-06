import '../models/question.dart';

final List<Question> sampleQuestions = [
  Question(
    assetPath: 'assets/images/apple.png',
    networkUrl: 'https://i.imgur.com/3ZQ3Z0y.png', // apple
    correct: 'APPLE',
    options: ['APPLE', 'APLE', 'APPEL', 'APPLI'],
  ),
  Question(
    assetPath: 'assets/images/ball.png',
    networkUrl: 'https://i.imgur.com/1Xn4Y3f.png', // ball
    correct: 'BALL',
    options: ['BALL', 'BOL', 'BAL', 'BELL'],
  ),
  Question(
    assetPath: 'assets/images/cat.png',
    networkUrl: 'https://i.imgur.com/9bK6hK7.png', // cat
    correct: 'CAT',
    options: ['CAT', 'KAT', 'CT', 'CAR'],
  ),
  Question(
    assetPath: 'assets/images/dog.png',
    networkUrl: 'https://i.imgur.com/fYQq9YV.png', // dog
    correct: 'DOG',
    options: ['DOG', 'DG', 'DUG', 'DOOG'],
  ),
];
