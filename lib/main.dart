import './screens/meal_detail_screen.dart';
import 'package:flutter/material.dart';
import 'screens/tabs_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/tabs_screen_bottom.dart';
import 'screens/filter_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((meal) => mealId == meal.id);

    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((meal) => mealId == meal.id));
      });
    }
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desi Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
                fontSize: 24.0,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                //color: Colors.white,
              ),
            ),
      ),
      //home: CategoryScreen("Desi Meals"),
      initialRoute: '/', //this is by default
      routes: {
        '/': (ctx) => TabsScreenBottom(_favouriteMeals),
        CategoryMealsScreen.routName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routName: (ctx) =>
            MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FilterScreen.routName: (ctx) => FilterScreen(_filters, _setFilters),
      },

      //     not often used
      //     This(onGenerateRoute:) is mainly used, where routNames are generated dynamically
      //     onGenerateRoute: (settings) {
      //       print(settings.arguments);
      //       if (settings.name == '/Meal-Detail')
      //         return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen());
      //       else if (settings.name == '/some-other-link') return MaterialPageRoute(builder: (ctx) => MealDetailScreen());
      //     },
      // acts as a 404 Error page,
      // or a page which should come if the desired page doesnot exists
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => TabsScreen(_favouriteMeals));
      },
    );
  }
}
