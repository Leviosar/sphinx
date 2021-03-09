import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../models/category.dart';
import '../models/user.dart';
import '../requests/GetCategoriesRequest.dart';
import 'categories_bloc.dart';

class UserBloc extends BlocBase {

  BehaviorSubject<User> _user = BehaviorSubject<User>();

  BehaviorSubject<User> get getUser => this._user;
  
  set user(User user) => this._user.add(user);

  Future<User> refresh() {
    return this.getUser.first;
  }

  Future<User> auth() async {
    User user = await this.getUser.first;
    
    http.Response response = await GetCategoriesRequest(user).send();
    
    List<dynamic> data = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      List<Category> categories = List.generate(data.length, (index) => Category.fromJson(data[index]));

      BlocProvider.getBloc<CategoriesBloc>().categories = categories;
    }
  }
}