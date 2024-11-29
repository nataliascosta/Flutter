import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _recipes = [];

  List<Recipe> get recipes => _recipes;

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners(); // Notifica os widgets que dependem dessa lista
  }

  void toggleFavoriteStatus(Recipe recipe) {
    final index = _recipes.indexOf(recipe);
    if (index >= 0) {
      _recipes[index].isFavorite = !_recipes[index].isFavorite;
      notifyListeners(); // Atualiza os widgets dependentes
    }
  }
}
