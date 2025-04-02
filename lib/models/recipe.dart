import 'package:hive/hive.dart';

part 'recipe.g.dart'; // Generated file

@HiveType(typeId: 0)
class Recipe {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String imagePath; // Path to the locally stored image

  @HiveField(2)
  final String ingredients;

  @HiveField(3)
  final String instructions;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final bool isFeatured; // To identify if it's "Hot Right Now"

  Recipe({
    required this.title,
    required this.imagePath,
    required this.ingredients,
    required this.instructions,
    required this.category,
    this.isFeatured = false,
  });
}