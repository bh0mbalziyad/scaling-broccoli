import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;

  FavoritesScreen(this._favoriteMeals);

  @override
  Widget build(BuildContext context) {
    return _favoriteMeals.length == 0
        ? Center(
            child: Text('You have no favorites yet - start adding some!'),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final Meal meal = _favoriteMeals[index];
              return MealItem(
                id: meal.id,
                affordability: meal.affordability,
                complexity: meal.complexity,
                duration: meal.duration,
                imageUrl: meal.imageUrl,
                title: meal.title,
              );
            },
            itemCount: _favoriteMeals.length,
          );
  }
}
