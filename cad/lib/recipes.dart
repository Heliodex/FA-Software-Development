import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "recipe.dart";

// Recipes page
class Recipes extends StatelessWidget {
  final ThemeData theme;
  final List<Recipe> recipes;
  final void Function(BuildContext, Recipe) editRecipe;
  final void Function() addRecipe;
  final void Function(Recipe) deleteRecipe;
  const Recipes(this.theme, this.recipes, this.editRecipe, this.addRecipe,
      this.deleteRecipe,
      {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Card(
          margin: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: recipes
                  .map(
                    (e) => ListTile(
                      title:
                          Text(e.title, style: const TextStyle(fontSize: 20)),
                      subtitle: const Text("recipe"),
                      trailing: IconButton(
                        icon: const Icon(Symbols.delete),
                        onPressed: () {
                          deleteRecipe(e);
                        },
                      ),
                      onTap: () {
                        editRecipe(context, e);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addRecipe,
          tooltip: "Add recipe",
          child: const Icon(Symbols.add),
        ),
      );
}
