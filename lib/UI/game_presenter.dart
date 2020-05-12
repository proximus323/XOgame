import 'package:tic_tac_toe/AI/ai.dart';
import 'package:tic_tac_toe/AI/utils.dart';
import 'package:tic_tac_toe/storage/game_info_repository.dart';

class GamePresenter {

  void Function( int idx) showMoveOnUi;
  void Function(int winningPlayer) showGameEnd;

  GameInfoRepository _repository;
  Ai _aiPlayer;

  GamePresenter(this.showMoveOnUi, this.showGameEnd){
    _repository = GameInfoRepository.getInstance();
    _aiPlayer = Ai();
    
  }

  void onHumanPlayed(List<int> board) async{
    int evaluation = Utils.evaluateBoard(board);
    if (evaluation != Ai.NO_WINNERS_YET) {
      onGameEnd(evaluation);
      return;
    }
    int aiMove = await Future(() => _aiPlayer.play(board, Ai.AI_PLAYER));

    // do the next move
    board[aiMove] = Ai.AI_PLAYER;

    // evaluate the board after the AI player move
    evaluation = Utils.evaluateBoard(board);
    if (evaluation != Ai.NO_WINNERS_YET)
      onGameEnd(evaluation);
    else
      showMoveOnUi(aiMove);
  }

  void onGameEnd(int winner) {
    if (winner == Ai.AI_PLAYER) {
      _repository.addVictory(); // add to the bot victories :)
    }

    showGameEnd(winner);
  }
}