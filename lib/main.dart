import 'package:flutter/material.dart';

import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/filters_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'glutenFree': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

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
        '/': (context) => TabsScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
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
