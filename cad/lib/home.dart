import "package:flutter/material.dart";

// Home page
class Home extends StatelessWidget {
  final ThemeData theme;
  const Home(this.theme, {super.key});

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
            ],
          ),
        ),
      );
}
