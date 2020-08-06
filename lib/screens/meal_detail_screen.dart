import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-detail';
  final Function _toggleFavorite;
  final Function _isMealFavorite;

  MealDetailScreen(this._toggleFavorite, this._isMealFavorite);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String id = routeArgs['id'];

    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);

    final listOfSteps = ListView.builder(
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('#${index + 1}'),
            ),
            title: Text('${selectedMeal.steps[index]}'),
          ),
          Divider(),
        ],
      ),
      itemCount: selectedMeal.steps.length,
    );

    final listOfIngredients = ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(selectedMeal.ingredients[index]),
          ),
        );
      },
      itemCount: selectedMeal.ingredients.length,
    );

    final mealImage = Container(
      height: 300,
      width: double.infinity,
      child: Image.network(
        selectedMeal.imageUrl,
        fit: BoxFit.cover,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            mealImage,
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              child: listOfIngredients,
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              child: listOfSteps,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          _isMealFavorite(id) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          this._toggleFavorite(id);
          return;
        },
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: Theme.of(context).textTheme.headline6),
    );
  }

  Widget buildContainer({@required Widget child}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }
}
