import "package:flutter/material.dart";

// Home page
class Home extends StatelessWidget {
  final ThemeData theme;
  final int targetCount, recipeCount;
  const Home(this.theme, this.targetCount, this.recipeCount, {super.key});

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.all(8),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Healthy eating application",
                style: theme.textTheme.titleLarge,
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Welcome to Healthy eating application, a personal health target and recipe tracker.\n\nHead to the Targets page to create a target – edit one to add milestones to it, and mark them as complete when you achieve them.\n\nHead to the Recipes page to add a recipe – edit one to add ingredients and steps to it.\n\nGet started by adding a target or recipe!",
                  style: theme.textTheme.bodyLarge,
                ),
              ),

              const SizedBox(height: 30),

              // stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Targets",
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        targetCount.toString(),
                        style: theme.textTheme.titleLarge,
                      ),
                    ],
                  ),
                  Column(children: [
                    Text(
                      "Recipes",
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      recipeCount.toString(),
                      style: theme.textTheme.titleLarge,
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
      );
}
