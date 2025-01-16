import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:flutter/services.dart";
import "lib.dart";

class Ingredient {
  String name, unit;
  double quantity; // eh
  Ingredient(this.name, this.quantity, this.unit);
}

class Recipe {
  String title;
  List<Ingredient> ingredients = [];
  Recipe(this.title);
}

class RecipePageState extends State<RecipePage> {
  addIngredient() {
    var name = "";
    var quantity = .0;
    var unit = "";

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Add an ingredient"),
              const SizedBox(height: 15),

              //  input box
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ingredient name",
                ),
                onChanged: (v) {
                  name = v;
                },
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Quantity",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  // allow digits and a single dot
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                onChanged: (v) {
                  quantity = double.tryParse(v) ?? 0;
                },
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Quantity unit",
                ),
                onChanged: (v) {
                  unit = v;
                },
              ),

              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    widget.e.ingredients.add(Ingredient(name, quantity, unit));
                  });
                },
                child: const Text("Add ingredient"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(
          title: Text("Edit recipe: ${widget.e.title}"),
          // pencil icon to rename
          actions: [
            IconButton(
              icon: const Icon(Symbols.edit),
              onPressed: () {
                rename(context, "recipe", (name) {
                  setState(() {
                    widget.e.title = name;
                  });
                  widget.renameRecipe(name);
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 15),
            Column(
              children: [
                // ingredients
                Column(
                  children: widget.e.ingredients
                      .map<ListTile>(
                        (m) => ListTile(
                          title: Text(m.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${m.quantity} ${m.unit}"),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),

                // add milestone button
                ElevatedButton(
                  onPressed: () {
                    addIngredient();
                  },
                  child: const Text("Add ingredient"),
                ),

                const SizedBox(height: 15),
                // delete button
                ElevatedButton(
                  onPressed: () {
                    confirmation(context, "delete this recipe", () {
                      Navigator.pop(context);
                      setState(() {
                        widget.removeRecipe();
                      });
                    });
                  },
                  child: const Text("Delete recipe"),
                ),
              ],
            ),
          ],
        ),
      );
}

class RecipePage extends StatefulWidget {
  final Recipe e;
  final Function() removeRecipe;
  final Function(String) renameRecipe;
  const RecipePage(this.e,
      {required this.removeRecipe, required this.renameRecipe, super.key});

  @override
  createState() => RecipePageState();
}
