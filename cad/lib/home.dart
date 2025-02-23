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
              Text(
                "Application homepage\nLog your targets, recipes, etc",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),

              const SizedBox(height: 50),

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
