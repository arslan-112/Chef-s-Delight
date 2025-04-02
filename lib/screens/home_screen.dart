import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/recipe.dart';
// import 'add_recipe_screen.dart'; // Commented out since not yet defined
// import 'recipe_detail_screen.dart'; // Commented out since not yet defined
import '../widgets/recipe_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xF7F19090),
        title: Text(
          "Chef's Book",

          style: TextStyle(fontFamily: "PinkSweats", fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Recipe>>(
        valueListenable: Hive.box<Recipe>('recipes').listenable(),
        builder: (context, box, _) {
          final recipes = box.values.toList().cast<Recipe>();

          // Filter featured recipes
          final featuredRecipes = recipes.where((recipe) => recipe.isFeatured).toList();

          // Group recipes by category
          final Map<String, List<Recipe>> categorizedRecipes = {};
          for (var recipe in recipes) {
            categorizedRecipes.putIfAbsent(recipe.category, () => []).add(recipe);
          }

          return ListView(
            children: [
              // Hot Right Now Section
              SizedBox(),
              Container(
                color: Color(0xF7d683ba),
                child: Padding(

                  padding: const EdgeInsets.all(10.0),
                  child: Center (
                      child: Text(
                        "Hot Right Now 🔥",

                        style: TextStyle(fontFamily: "QuiteMagical", fontSize: 30, color: Colors.white),
                      ) ,
                  )

                ),

              ),

              Container(
                height: featuredRecipes.isEmpty ? 0 : null,
                child: Column(
                  children: featuredRecipes.map((recipe) {
                    return RecipeCard(
                      recipe: recipe,
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => RecipeDetailScreen(recipe: recipe),
                        //   ),
                        // );
                      },
                    );
                  }).toList(),
                ),
              ),

              // Recipes by Category
              ...categorizedRecipes.entries.map((entry) {
                final category = entry.key;
                final categoryRecipes = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(0xCDA50180),
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              category,
                              style: TextStyle(fontFamily: "QuiteMagical", fontSize: 30, color: Colors.white),
                            ),
                          )
                      ),
                    ),

                    Container(
                      height: categoryRecipes.isEmpty ? 0 : null,
                      child: Column(
                        children: categoryRecipes.map((recipe) {
                          return RecipeCard(
                            recipe: recipe,
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => RecipeDetailScreen(recipe: recipe),
                              //   ),
                              // );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => AddRecipeScreen()),
          // );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}