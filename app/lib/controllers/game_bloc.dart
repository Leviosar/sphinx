
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:sphinx/controllers/user_bloc.dart';
import 'package:sphinx/models/user.dart';
import 'package:sphinx/requests/StoreGameRequest.dart';

import '../models/game.dart';

class GameBloc extends BlocBase {

  BehaviorSubject<Game> _currentGame = BehaviorSubject<Game>();

  BehaviorSubject<Game> get getCurrentGame => this._currentGame;
  
  set currentGame(Game game) => this._currentGame.add(game);

  void saveGame(Game game) async {
    game.end = DateTime.now();

    User user = await BlocProvider.getBloc<UserBloc>().getUser.first;

    http.Response response = await StoreGameRequest(user, game).send();
    
    print(response.body);
  }
}