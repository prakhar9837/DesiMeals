import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routName = '/Meal-Detail';

  final Function toggleFavourites;
  final Function isFavourite;

  MealDetailScreen(this.toggleFavourites, this.isFavourite);
  // List returnIngredient(ingre) {
  //   final val = ingre.map((ele) {
  //     return Text(ele);
  //   }).toList();
  //   return val;
  // }

  Widget buildSectionTitle(context, text) {
    return Container(
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      height: 170.0,
      width: 300.0,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    //final mealId = routeArgs['id'];

    final mealDetail = DUMMY_MEALS.firstWhere((meal) {
      return (meal.id == mealId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(mealDetail.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 300.0,
                width: double.infinity,
                margin: EdgeInsets.all(10.0),
                child: Image.network(
                  mealDetail.imageUrl,
                  fit: BoxFit.cover,
                )),
            buildSectionTitle(context, 'Ingredients :-'),
            //...returnIngredient(mealDetail.ingredients),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${index + 1}.  ${mealDetail.ingredients[index]}',
                        style: TextStyle(),
                      ),
                    ),
                  );
                },
                itemCount: mealDetail.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps :-'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('#${index + 1}'),
                        ),
                        title: Text(mealDetail.steps[index]),
                      ),
                      Divider(
                        color: Colors.red,
                      ),
                    ],
                  );
                },
                itemCount: mealDetail.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavourite(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavourites(mealId),
      ),
    );
  }
}
