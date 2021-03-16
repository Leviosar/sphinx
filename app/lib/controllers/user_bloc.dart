import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:sphinx/requests/GetRankingRequest.dart';
import 'package:sphinx/requests/RegisterUser.dart';

import '../models/user.dart';
import 'categories_bloc.dart';

class UserBloc extends BlocBase {

  BehaviorSubject<User> _user = BehaviorSubject<User>();
  BehaviorSubject<List<User>> _ranking = BehaviorSubject<List<User>>();

  BehaviorSubject<User> get getUser => this._user;
  set user(User user) => this._user.add(user);

  BehaviorSubject<List<User>> get getRanking => this._ranking;
  set ranking(List<User> ranking) => this._ranking.add(ranking);

  Future<User> refresh() {
    return this.getUser.first;
  }

  void auth() async {
    User user = await this.getUser.first;
    
    http.Response authResponse = await RegisterUser(user).send();

    if (authResponse.statusCode == 200) {
      BlocProvider.getBloc<CategoriesBloc>().fetchCategories();
      this.fetchRanking();
    }
  }

  void fetchRanking() async {
    User user = await BlocProvider.getBloc<UserBloc>().getUser.first;
    
    http.Response response = await GetRankingRequest(user).send();
      
    List<dynamic> data = jsonDecode(response.body);
    print(data);
  
    if (response.statusCode == 200) {
      List<User> ranking = List.generate(data.length, (index) => User.fromJson(data[index]));
      this.ranking = ranking;
    } else {
      print('Deu ruim buscando ranking');
    }
  }
}