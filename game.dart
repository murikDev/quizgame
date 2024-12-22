import 'dart:math';
import 'dart:io';


class Game {
  String name = "Quiz Game";
  Player player;
  List<Question> questions = [
    Question(question: {"UK paytagty?": [{"London": true}, {"Moscow": false}, {"New York": false}]}),
    Question(question: {"Dunyadaki in uly derya?": [{"Amazonka": false}, {"Nil": true}, {"Missuri": false}]}),
    Question(question: {"Gune in yakyn planete?": [{"Merkuriy": true}, {"Yer": false}, {"Mars": false}]}),
    Question(question: {"In uly okean?": [{"Atlantik": false}, {"Hindi": false}, {"Yuwash": true}]}),
  ];

  Game({
    required this.player,
  });

  Question getQuestion() {
    var random = Random();
    int randomIndex = random.nextInt(questions.length);
    Question randomQuestion = questions[randomIndex];
    questions.remove(randomQuestion);
    return randomQuestion;
  }

  bool checkAnswer(String answer, Question question) {
    answer = answer.toLowerCase().trim();
    for (var entry in question.question.entries) {
      for (var option in entry.value) {
        for (var key in option.keys) {
          if (key.toLowerCase() == answer && option[key] == true) {
            return true;
          }
        }
      }
    }
    return false;
  }
}

class Player {
  String name;
  int score;

  Player({
    required this.name,
    this.score = 0
  });

  addToScore() {
    this.score +=1;
  }
}

class Question {
  final Map<String, List<Map<String, bool>>> question;

  Question({
     required this.question
  });

  @override
  String toString() {
    // Sorag we jogap opsiýalaryny owadan formatlamak üçin
    return question.entries.map((entry) {
      String questionText = entry.key; // Текст вопроса
      String answers = entry.value
          .map((option) {
        // Jogap wariantlaryndan geçýäris
        return option.entries.map((answer) {
          return '${answer.key}';
        }).join(", ");
      })
          .join(", ");
      return 'Sorag: $questionText\nJogaplary: $answers';
    }).join("\n\n");
  }
}

void main() {
  final player = Player(name: 'Myrat');
  final game = Game(player: player);

  while (!game.questions.isEmpty) {
    final randomQuestion = game.getQuestion();
    print(randomQuestion);
    print('Sizin jogabynyz: ');
    String? answer = stdin.readLineSync();

    bool check = game.checkAnswer(answer!, randomQuestion);
    if (check) {
      player.addToScore();
    }
  }

  print('Sizin gorkezen netijaniz ${player.score} den boldy');
}