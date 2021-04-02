import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sphinx/controllers/user_bloc.dart';
import 'package:sphinx/models/user.dart';
import 'package:sphinx/requests/GetCategoriesRequest.dart';
import '../models/category.dart';
import 'package:http/http.dart' as http;

class CategoriesBloc extends BlocBase {

  BehaviorSubject<List<Category>> _categories = BehaviorSubject<List<Category>>();

  BehaviorSubject<List<Category>> get getCategories => this._categories;
  
  set categories(List<Category> categories) => this._categories.add(categories);

  void fetchCategories() async {
    User user = await BlocProvider.getBloc<UserBloc>().getUser.first;
    
    http.Response response = await GetCategoriesRequest(user).send();
      
    List<dynamic> data = jsonDecode(response.body);
  
    if (response.statusCode == 200) {
      List<Category> categories = List.generate(data.length, (index) => Category.fromJson(data[index]));
      this.categories = categories;
    } else {
      print('Deu ruim buscando categorias');
    }
  }
}