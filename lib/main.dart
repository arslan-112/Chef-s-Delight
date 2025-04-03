import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/recipe.dart';
import 'screens/home_screen.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register the Recipe adapter
  Hive.registerAdapter(RecipeAdapter());

  // Open a Hive box for recipes
  await Hive.openBox<Recipe>('recipes');

  // Add predefined recipes if the box is empty
  final recipeBox = Hive.box<Recipe>('recipes');
  if (recipeBox.isEmpty) {
    addPredefinedRecipes(recipeBox);
  }

  runApp(MyApp());
}

// Function to add predefined recipes
void addPredefinedRecipes(Box<Recipe> recipeBox) {
  recipeBox.addAll([
    Recipe(
      title: 'Spaghetti Carbonara',
      imagePath: 'assets/images/carbonara.webp',
      ingredients:
          'Pasta, Egg yolks and whole eggs,Parmigiano reggiano, Guanciale, Pepper',
      instructions:
          '1. Batons – Cut the guanciale into thick batons. Biting through the golden brown crust into meaty bits of salty guanciale is part of the awesomeness that is carbonara! '
          '2. Finely grate the parmigiana reggiano or pecorino. I use a microplane – one of can’t-live-without kitchenware items!'
          '3. Sauce – Whisk together the egg, cheese and pepper in a large bowl. It needs to be a large bowl because the pasta will be stirred into the sauce in the bowl, off the stove, to avoid scrambling the eggs.'
          '4. Cook pasta – Bring 4 litres (4 quarts) of water to the boil with 1 tablespoon of salt. Cook the pasta per packet directions. It should be firm, not soft, but fully cooked through.'
          '5. Reserve pasta cooking water – Just before draining, scoop out one cup of pasta cooking water. Then drain the pasta in a colander.'
          '6. Cook guanciale until golden while the pasta is cooking. You don’t need any oil, the guanciale will fry in its own fat.'
          '7. Transfer into sauce bowl – Tip the hot pasta into the bowl with the egg and use a rubber spatula to scrape out every drop of the guanciale fat into the bowl. That stuff is gold! 🙂'
          '8. Add 1/2 cup pasta cooking water into the bowl.'
          '9. Mix vigorously with the handle of a wooden spoon, spinning the pasta around, for around 30 seconds to 1 minute. Watch as the watery pale yellow liquid magically transforms into a creamy sauce. '
          'You know it’s ready when the sauce is no longer watery and pooled in the bottom of the bowl. Instead, it will be thickened, creamy, and clinging to the pasta!',
      category: 'Italian',
      isFeatured: true,
    ),
    Recipe(
      title: 'Chicken Biryani',
      imagePath: 'assets/images/Biryani.jpg',
      ingredients:
          'Oil/Ghee, Onions, Bone-in, cut up, skinless chicken, Whole spices,Garlic + Ginger,Tomatoes,Yogurt,Rice',
      instructions:
          '1. Prepare the chicken curry. Prepare the biryani masala (or use store-bought) and marinate the chicken. Start the chicken curry. While the chicken cooks over low heat, make the rice. '
          '2. Prepare the rice. Bring a pot of water to a boil and parboil the rice. Drain and set aside. '
          '3. Bring it all together for a final steam (‘dum‘). Layer half of the rice, all of the chicken, and then the remaining rice on top. Add the finishing touches. Allow steam to develop, then lower the heat and let the flavors meld.',
      category: 'Pakistani',
      isFeatured: true,
    ),
    Recipe(
      title: 'Sushi Rolls',
      imagePath: 'assets/images/sushi_rolls.jpg',
      ingredients: 'Rice, Nori, Fish, Vegetables',
      instructions:
          '1. Place sushi rice in a fine-mesh strainer and rinse under cold water until the water runs clear (about 3–4 times).'
          '2. Combine rinsed rice and water in a pot. Bring to a boil, then reduce heat to low, cover, and simmer for 15 minutes. Remove from heat and let it sit (covered) for 10 minutes.'
          '3. In a small bowl, mix rice vinegar, sugar, and salt. Microwave for 20 seconds to dissolve. Transfer cooked rice to a large bowl, drizzle with vinegar mixture, and gently fold with a wooden spatula. Let it cool to room temperature.'
          '4. Prep the Fillings'
          '5. Assemble the Sushi Roll '
          '6. Add Fillings'
          '7. Roll Tightly'
          '8. Slice the Roll'
          '9. Repeat & Serve',
      category: 'Japanese',
      isFeatured: true,
    ),
    Recipe(
      title: 'Tacos',
      imagePath: 'assets/images/tacos.webp',
      ingredients: 'Tortillas, Meat, Lettuce, Cheese',
      instructions:
          '1. Place the ground beef in a skillet with olive oil.'
          '2. Brown the beef with olive oil and then drain any fat.'
          '3. Add the spices along with the tomato paste and water (or tomato sauce)'
          '4. Bring the mixture to a simmer and then cook for a few more minutes until the sauce thickens.',
      category: 'Mexican',
    ),
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
