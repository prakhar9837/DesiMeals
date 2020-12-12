import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favourites.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreenBottom extends StatefulWidget {
  final List<Meal> favouriteMeals;
  TabsScreenBottom(this.favouriteMeals);
  @override
  _TabsScreenBottomState createState() => _TabsScreenBottomState();
}

class _TabsScreenBottomState extends State<TabsScreenBottom> {
  int _indexTab = 0;
  List<Map<String, Object>> _pages;

  void _selectTab(int index) {
    setState(() {
      _indexTab = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'page': CategoryScreen(),
        'title': Text('Categories'),
        //'actions': [FlatBotton( )] In this way we can add some action buttons
      },
      {
        'page': Favourites(widget.favouriteMeals),
        'title': Text('Favourites'),
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _pages[_indexTab]['title'],
      ),
      drawer: MainDrawer(),
      body: _pages[_indexTab]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _indexTab,
        unselectedFontSize: 12.0,
        selectedFontSize: 15.0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
