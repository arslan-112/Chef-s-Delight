import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/recipe.dart';
import 'add_recipe_screen.dart';
// import 'recipe_detail_screen.dart'; // Commented out since not yet defined
import '../widgets/recipe_card.dart';
import '../widgets/custom_appbar.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CustomAppBar(title: "Chef's Book"),
      body: ValueListenableBuilder<Box<Recipe>>(
        valueListenable: Hive.box<Recipe>('recipes').listenable(),
        builder: (context, box, _) {
          final recipes = box.values.toList().cast<Recipe>();

          // Filter featured recipes
          final featuredRecipes = recipes.where((recipe) => recipe.isFeatured).toList();

          // Group recipes by category
          final Map<String, List<Recipe>> categorizedRecipes = {};

          for (var recipe in recipes) {
            String category = recipe.category.trim().toLowerCase(); // Normalize category name
            if (!categorizedRecipes.containsKey(category)) {
              categorizedRecipes[category] = [];
            }
            categorizedRecipes[category]!.add(recipe);
          }

          return ListView(
            children: [
              // Hot Right Now Section
              SizedBox(),
              Container(
                color: Color(0xFFF5F5F5),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8,14,8,0),
                  child: Center(
                    child: Text(
                      "Hot Right Now 🔥",
                      style: TextStyle(fontFamily: "QuiteMagical", fontSize: 32, color: Colors.black87),
                    ),
                  ),
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
                      color: Color(0xFFF5F5F5),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8,12,8,0),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(fontFamily: "QuiteMagical", fontSize: 35, color: Colors.black87),
                          ),
                        ),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRecipeScreen()),
          );
        },
        backgroundColor: Color(0xFFFFFEFE),
        foregroundColor: Colors.black,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}