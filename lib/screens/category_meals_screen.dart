import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen({
  //   @required this.categoryId,
  //   @required this.categoryTitle,
  // });

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String categoryTitle = routeArgs['title'];
    final String categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS
        .where((element) => element.categories.contains(categoryId))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (
          ctx,
          index,
        ) {
          final meal = categoryMeals[index];
          return MealItem(
            id: meal.id,
            title: meal.title,
            imageUrl: meal.imageUrl,
            affordability: meal.affordability,
            complexity: meal.complexity,
            duration: meal.duration,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
