// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    //^ name gives the acces to the enum value as the string
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

  String get affordableText {
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //^ by default the stack ignores the shape of the card, so to ensure that doesnt happen we provide some settings
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      child: InkWell(
        // onTap: () =>Navigator.push(context,MaterialPageRoute(builder: (_)=>MealDetailsScreen(meal: meal))),
        onTap: ()=> onSelectMeal(meal),
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 220,
              width: double.infinity,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis, //&very long text...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordableText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
