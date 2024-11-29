import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../provider/recipe_provider.dart';
import 'add_recipe_screen.dart';
import 'favorite_recipes_screen.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Receitas'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Início'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu lateral
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Receitas Favoritas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FavoriteRecipesScreen(recipes: recipeProvider.recipes),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: recipeProvider.recipes.isEmpty
          ? Center(
              child: Text(
                'Nenhuma receita adicionada.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: recipeProvider.recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipeProvider.recipes[index];
                return Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color:
                        recipe.isFavorite ? Colors.blue[50] : Colors.green[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: _buildRecipeTile(context, recipe, recipeProvider),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecipeScreen(
                onAddRecipe: (recipe) => recipeProvider.addRecipe(recipe),
              ),
            ),
          );
        },
        child: Text(
          '+',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildRecipeTile(
      BuildContext context, Recipe recipe, RecipeProvider recipeProvider) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            recipe.title,
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(
              recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => recipeProvider.toggleFavoriteStatus(recipe),
          ),
        ],
      ),
    );
  }
}
