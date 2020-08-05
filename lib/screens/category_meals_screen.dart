import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> _availableMeals;

  CategoryMealsScreen(this._availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  List<Meal> _displayedMeals;
  bool _loadedInitData = false;

  @override
  void initState() {
    // ...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_loadedInitData) {
      final _routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      _categoryTitle = _routeArgs['title'];
      final String _categoryId = _routeArgs['id'];
      _displayedMeals = widget._availableMeals
          .where((element) => element.categories.contains(_categoryId))
          .toList();
      super.didChangeDependencies();
      _loadedInitData = true;
    }
  }

  void _removeItem(String mealId) {
    setState(() {
      _displayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (
          ctx,
          index,
        ) {
          final meal = _displayedMeals[index];
          return MealItem(
            id: meal.id,
            title: meal.title,
            imageUrl: meal.imageUrl,
            affordability: meal.affordability,
            complexity: meal.complexity,
            duration: meal.duration,
            removeItem: _removeItem,
          );
        },
        itemCount: _displayedMeals.length,
      ),
    );
  }
}
