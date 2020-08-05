import 'package:flutter/material.dart';

import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;

  FavoritesScreen(this._favoriteMeals);

  @override
  Widget build(BuildContext context) {
    return _favoriteMeals.length == 0
        ? Center(
            child: Text('You have no favorites yet - start adding some!'),
          )
        : Center(
            child: Text('Loading...'),
          );
  }
}
