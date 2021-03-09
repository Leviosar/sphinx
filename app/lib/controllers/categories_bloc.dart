import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import '../models/category.dart';

class CategoriesBloc extends BlocBase {

  BehaviorSubject<List<Category>> _categories = BehaviorSubject<List<Category>>();

  BehaviorSubject<List<Category>> get getCategories => this._categories;
  
  set categories(List<Category> categories) => this._categories.add(categories);
}