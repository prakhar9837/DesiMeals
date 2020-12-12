import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routName = '/category-meals';

  final List<Meal> _availableMeals;
  CategoryMealsScreen(this._availableMeals);
  // final String id;
  // final String title;
  // CategoryMealsScreen(this.id, this.title);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String catTitle;
  List<Meal> displayedMeals;

  @override
  void didChangeDependencies() {
    final Map<String, String> routeArgs =
        ModalRoute.of(context).settings.arguments;
    final categoryId = routeArgs['id'];
    catTitle = routeArgs['title'];

    displayedMeals = widget._availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void favItem(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => mealId == meal.id);
    });

    // for (int i = 0; i < displayedMeals.length; i++) {
    //   if (mealId == displayedMeals[i].id) {
    //     displayedMeals.removeAt(i);
    //     print(mealId);
    //   }
    // }
    //});
  }

  @override
  Widget build(BuildContext context) {
    // final routeArgs =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
