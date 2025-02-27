import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "lib.dart";
import "home.dart";
import "target.dart";
import "targets.dart";
import "recipe.dart";
import "recipes.dart";
import "notifications.dart";
import "data.dart";

class NavigationState extends State<Navigation> {
  List<Target> targets = [];
  List<Recipe> recipes = [];

  load() async {
    targets = await loadTargets();
    recipes = await loadRecipes();
  }

  var currentPageIndex = 0;

  List<AppNotification> notifications = [
    AppNotification(Symbols.dinner_dining, "Notifications", "sup",
        DateTime(2025, 01, 15, 20, 18, 04)),
    AppNotification(Symbols.dinner_dining, "Notification 2",
        "test notification", DateTime(2024, 07, 20, 20, 18, 04)),
  ];

  addTarget() {
    var name = "";

    dialog(
      context,
      "Create a target",
      [
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Target name",
          ),
          onChanged: (v) {
            name = v;
          },
        ),
      ],
      [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              targets.add(Target(name));
              saveTargets(targets);
            });
          },
          child: const Text("Add target"),
        ),
      ],
    );
  }

  addRecipe() {
    var name = "";

    dialog(context, "Create a recipe", [
      TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Recipe name",
        ),
        onChanged: (v) {
          name = v;
        },
      ),
    ], [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            recipes.add(Recipe(name));
            saveRecipes(recipes);
          });
        },
        child: const Text("Add recipe"),
      ),
    ]);
  }

  deleteRecipe(Recipe e) {
    confirmation(context, "delete this recipe", () {
      setState(() {
        recipes.remove(e);
        saveRecipes(recipes);
      });
    });
  }

  editTarget(BuildContext context, Target e) {
    var route = MaterialPageRoute(
      builder: (context) => TargetPage(
        e,
        removeTarget: () {
          setState(() {
            targets.remove(e);
            saveTargets(targets);
          });
        },
        renameTarget: (name) {
          setState(() {
            e.title = name;
            updateTarget(e);
          });
        },
        addMilestone: (Milestone m) {
          setState(() {
            e.milestones.add(m);
            updateTarget(e);
          });
        },
        removeMilestone: (Milestone m) {
          setState(() {
            if (e.completed > e.milestones.indexOf(m)) {
              e.completed--;
            }
            e.milestones.remove(m);
            updateTarget(e);
          });
        },
        updateMilestone: (n) {
          setState(() {
            e.completed += n;
            updateTarget(e);
          });
        },
      ),
    );

    Navigator.push(context, route);
  }

  editRecipe(BuildContext context, Recipe e) {
    var route = MaterialPageRoute(
      builder: (context) => RecipePage(
        e,
        removeRecipe: () {
          setState(() {
            recipes.remove(e);
            saveRecipes(recipes);
          });
        },
        renameRecipe: (name) {
          setState(() {
            e.title = name;
            updateRecipe(e);
          });
        },
      ),
    );

    Navigator.push(context, route);
  }

  destinationSelected(index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  initState() {
    super.initState();
    load().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final pages = [
      // Home page
      Home(theme, targets.length, recipes.length),
      // Targets page
      Targets(theme, targets, editTarget, addTarget),
      // Recipes page
      Recipes(theme, recipes, editRecipe, addRecipe, deleteRecipe),
      // Notifications page
      Notifications(theme, notifications),
    ];

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.purple[900],
        onDestinationSelected: destinationSelected,
        indicatorColor: Colors.purpleAccent[700],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Symbols.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Symbols.target),
            label: "Targets",
          ),
          NavigationDestination(
            icon: Icon(Symbols.dinner_dining),
            label: "Recipes",
          ),
          NavigationDestination(
            icon: Icon(Symbols.notifications),
            label: "Notifications",
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  createState() => NavigationState();
}

// class helps with hot reloading
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) => MaterialApp(
        theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
        home: const Navigation(),
      );
}

void main() => runApp(const App());
