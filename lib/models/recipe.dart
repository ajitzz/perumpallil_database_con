import 'package:flutter/material.dart';

class Recipe {
  Recipe(
      {this.recipeName = '',
      this.recipeImage = '',
      this.recipeMaker = '',
      this.startColor,
      this.endColor});

  String recipeName;
  String recipeImage;
  String recipeMaker;
  Color? startColor;
  Color? endColor;
}

var recipes = [
  Recipe(
    recipeName: ' ',
    recipeImage: 'ad1.jpeg',
    recipeMaker: 'Foodie Yuki',
    startColor: const Color.fromARGB(0, 117, 1, 1),
    endColor: const Color.fromARGB(249, 18, 17, 17),
  ),
  Recipe(
    recipeName: '',
    recipeImage: 'christmass.jpeg',
    recipeMaker: 'Marianne Turner',
    startColor: const Color.fromARGB(0, 98, 30, 20),
    endColor: const Color.fromARGB(0, 209, 58, 16),
  ),
];
