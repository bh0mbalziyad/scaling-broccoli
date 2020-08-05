import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function applyFilters;
  final Map<String, bool> initFilters;

  FiltersScreen(this.applyFilters, {@required this.initFilters});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.initFilters['glutenFree'];
    _isVegan = widget.initFilters['vegan'];
    _isVegetarian = widget.initFilters['vegetarian'];
    _lactoseFree = widget.initFilters['lactose'];

    super.initState();
  }

  void _onSaveFilters() {
    final Map<String, bool> _filters = {
      'glutenFree': _glutenFree,
      'lactose': _lactoseFree,
      'vegan': _isVegan,
      'vegetarian': _isVegetarian,
    };
    widget.applyFilters(_filters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your filters!'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _onSaveFilters,
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten Free',
                  'Only show gluten free meals',
                  _glutenFree,
                  (val) {
                    setState(() {
                      _glutenFree = val;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only show vegan meals',
                  _isVegan,
                  (val) {
                    setState(() {
                      _isVegan = val;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only show vegetarian meals',
                  _isVegetarian,
                  (val) {
                    setState(() {
                      _isVegetarian = val;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Lactose Free',
                  'Only show lactose free meals',
                  _lactoseFree,
                  (val) {
                    setState(() {
                      _lactoseFree = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SwitchListTile _buildSwitchListTile(
    String title,
    String desc,
    bool currentValue,
    Function update,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(desc),
      value: currentValue,
      onChanged: update,
    );
  }
}
