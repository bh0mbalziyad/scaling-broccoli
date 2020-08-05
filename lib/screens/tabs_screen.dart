import 'package:flutter/material.dart';

import './favorites_screen.dart';
import './categories_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeal;

  TabsScreen(this._favoriteMeal);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTab = 0;
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    this._pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget._favoriteMeal), 'title': 'Favorites'},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedTab]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedTab]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
        onTap: _selectPage,
        currentIndex: _selectedTab,
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedTab = index;
    });
  }
}
