
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../models/game.dart';

class GameBloc extends BlocBase {

  BehaviorSubject<Game> _currentGame = BehaviorSubject<Game>();

  BehaviorSubject<Game> get getCurrentGame => this._currentGame;
  
  set currentGame(Game game) => this._currentGame.add(game);
}