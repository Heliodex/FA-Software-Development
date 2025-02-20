import "package:cad/data.dart";
import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:flutter/services.dart";
import "lib.dart";

class Ingredient {
  String name, unit;
  double quantity; // eh
  Ingredient(this.name, this.quantity, this.unit);
}

class Step {
  String description;
  Step(this.description);
}

class Recipe {
  var title = "";
  List<Ingredient> ingredients = [];
  List<Step> steps = [];
  Recipe(this.title);

  Recipe.fromJson(Map<String, dynamic> decoded) {
    title = decoded["title"];
    for (var i in decoded["ingredients"]) {
      ingredients.add(Ingredient(i["name"], i["quantity"], i["unit"]));
    }
    for (var s in decoded["steps"]) {
      steps.add(Step(s));
    }
  }

  toJson() => {
        "title": title,
        "ingredients": ingredients
            .map((i) => {
                  "name": i.name,
                  "quantity": i.quantity,
                  "unit": i.unit,
                })
            .toList(),
        "steps": steps.map((s) => s.description).toList(),
      };
}

class RecipePageState extends State<RecipePage> {
  addIngredient() {
    var name = "";
    var quantity = .0;
    var unit = "";

    dialog(context, "Add an ingredient", [
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
    ], [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            widget.e.ingredients.add(Ingredient(name, quantity, unit));
            updateRecipe(widget.e);
          });
        },
        child: const Text("Add ingredient"),
      ),
    ]);
  }

  addStep(Step? step) {
    var description = "";
    if (step != null) {
      description = step.description;
    }

    dialog(
      context,
      step != null
          ? "Edit step ${widget.e.steps.indexOf(step) + 1}"
          : "Add a step",
      [
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Description",
            alignLabelWithHint: true,
          ),
          // add text to the description
          controller: TextEditingController(text: description),
          onChanged: (v) {
            description = v;
          },
          maxLines: 5,
        ),
      ],
      [
        if (step != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    step.description = description;
                    updateRecipe(widget.e);
                  });
                },
                child: const Text("Edit step"),
              ),
              const SizedBox(width: 15),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    widget.e.steps.remove(step);
                    updateRecipe(widget.e);
                  });
                },
                child: const Text("Delete step"),
              ),
            ],
          ),
        ] else
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                widget.e.steps.add(Step(description));
                updateRecipe(widget.e);
              });
            },
            child: const Text("Add step"),
          ),
      ],
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),
            Column(children: [
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
              // add ingredient button
              ElevatedButton(
                onPressed: addIngredient,
                child: const Text("Add ingredient"),
              ),

              const SizedBox(height: 15),
              Column(children: [
                // steps
                Column(
                  children: widget.e.steps
                      .map<ListTile>(
                        (m) => ListTile(
                          title: Text("Step ${widget.e.steps.indexOf(m) + 1}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(m.description),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Symbols.edit),
                            onPressed: () {
                              addStep(m);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ]),
              // add step button
              ElevatedButton(
                onPressed: () {
                  addStep(null);
                },
                child: const Text("Add step"),
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
              const SizedBox(height: 15),
            ]),
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
