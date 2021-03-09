import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../controllers/categories_bloc.dart';
import '../../models/category.dart';
import '../../widgets/side_banner.dart';

typedef CategoryListingCallback = Function(List<Category> selectedCategories);

class CategoryListing extends StatefulWidget {

  final CategoryListingCallback onSelected;

  const CategoryListing({Key key, this.onSelected}) : super(key: key);

  @override
  _CategoryListingState createState() => _CategoryListingState();
}

class _CategoryListingState extends State<CategoryListing> {

  List<bool> selectedCategories = [];
  List<Category> categories = [];

  @override
  void initState() {
    this.getCategories();
    super.initState();
  }

  getCategories() async {
    List<Category> data = await BlocProvider.getBloc<CategoriesBloc>().getCategories.first;
    
    setState(() {
      this.categories = data;
      this.selectedCategories = List.generate(this.categories.length, (_) => true);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<FilterChip> chips = List.generate(
      this.categories.length, 
      (index) => FilterChip(
        backgroundColor: Colors.grey,
        selectedColor: Theme.of(context).primaryColor,
        selected: this.selectedCategories[index],
        onSelected: (bool value) {
          setState(() {
            this.selectedCategories[index] = value;
          });
          this.widget.onSelected(this.categories);
        },
        label: Text(this.categories[index].title)
      )
    );

    return Column(
      children: [
        SideBanner(title: 'Categories'),
        Wrap(
          children: chips,
          alignment: WrapAlignment.center,
          spacing: 5.0,
        )
      ]
    );
  }
}