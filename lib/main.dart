import 'package:flutter/material.dart';

import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/filters_screen.dart';

import './models/meal.dart';
import './dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutenFree': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _applyFilter(Map<String, bool> filters) {
    setState(() {
      this._filters = filters;
      this._availableMeals = DUMMY_MEALS.where((meal) {
        if (this._filters['glutenFree'] && !meal.isGlutenFree) return false;
        if (this._filters['lactose'] && !meal.isLactoseFree) return false;
        if (this._filters['vegan'] && !meal.isVegan) return false;
        if (this._filters['vegetarian'] && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  void _toggleFavorite(String id) {
    final int mealIndex = _favoriteMeals.indexWhere((meal) => meal.id == id);

    if (mealIndex == -1) {
      // if meal is not in favorites
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == id));
        print('Added as favorite');
      });
    } else {
      // if meal is in favorites
      setState(() {
        _favoriteMeals.removeAt(mealIndex);
        print('Removed from favorite');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: const Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: const Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed'),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default value
      routes: {
        '/': (context) => TabsScreen(this._favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(this._availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(this._toggleFavorite, this._isMealFavorite),
        FiltersScreen.routeName: (context) => FiltersScreen(
              _applyFilter,
              initFilters: this._filters,
            ),
      },
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (contenxt) => CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        // similar to Err : 404
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
