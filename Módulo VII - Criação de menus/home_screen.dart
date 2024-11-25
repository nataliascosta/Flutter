import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'add_recipe_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Recipe> _recipes = [];

  void _addRecipe(Recipe recipe) {
    setState(() {
      _recipes.add(recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes =
        _recipes.where((recipe) => recipe.isFavorite).toList();
    final otherRecipes =
        _recipes.where((recipe) => !recipe.isFavorite).toList();

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
                Navigator.pop(context); // Fecha o menu lateral
                _showFavoriteRecipesDialog(context, favoriteRecipes);
              },
            ),
          ],
        ),
      ),
      body: _recipes.isEmpty
          ? Center(
              child: Text(
                'Nenhuma receita adicionada.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (favoriteRecipes.isNotEmpty)
                  Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Receitas Favoritas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: favoriteRecipes
                              .map((recipe) => _buildRecipeTile(recipe))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                if (otherRecipes.isNotEmpty)
                  Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Outras Receitas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: otherRecipes
                              .map((recipe) => _buildRecipeTile(recipe))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecipeScreen(onAddRecipe: _addRecipe),
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

  Widget _buildRecipeTile(Recipe recipe) {
    return Row(
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
          onPressed: () {
            setState(() {
              recipe.isFavorite = !recipe.isFavorite;
            });
          },
        ),
      ],
    );
  }

  void _showFavoriteRecipesDialog(BuildContext context, List<Recipe> recipes) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Receitas Favoritas'),
          content: recipes.isEmpty
              ? Text('Nenhuma receita favorita encontrada.')
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      recipes.map((recipe) => Text(recipe.title)).toList(),
                ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
