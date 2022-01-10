// ignore_for_file: unused_local_variable

import 'package:game/tic.dart';

class Games {
  List<String>? face;
  static List<String> gameFace() {
    return List.generate(9, (index) => Plays.z);
  }

  bool winnerOrFailed(String player, int index, List<int> scoreFace, int size) {
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 : -1;
    scoreFace[row] += score;
    scoreFace[size + col] += score;
    if (row == col) scoreFace[2 * size] += score;

    if (size - 1 - col == row) scoreFace[2 * size + 1] += score;

    if (scoreFace.contains(3) || scoreFace.contains(-3)) {
      return true;
    }
    return false;
  }
}
