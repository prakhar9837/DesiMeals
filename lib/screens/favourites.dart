import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class Favourites extends StatelessWidget {
  final List<Meal> favouriteMeals;
  Favourites(this.favouriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.length == 0) {
      return Center(
        child: Text('You have no favourites yet!!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageUrl: favouriteMeals[index].imageUrl,
            duration: favouriteMeals[index].duration,
            affordability: favouriteMeals[index].affordability,
            complexity: favouriteMeals[index].complexity,
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
