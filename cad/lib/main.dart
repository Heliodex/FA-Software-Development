import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "lib.dart";
import "recipe.dart";
import "target.dart";

class Notification {
  IconData icon;
  String title, subtitle;
  DateTime time;
  Notification(this.icon, this.title, this.subtitle, this.time);
}

class NavigationState extends State<Navigation> {
  var currentPageIndex = 0;

  List<Notification> notifications = [
    Notification(Symbols.dinner_dining, "Notifications", "sup",
        DateTime(2019, 07, 20, 20, 18, 04)),
    Notification(Symbols.dinner_dining, "Notification 2", "sup",
        DateTime(2019, 07, 20, 20, 18, 04)),
  ];
  List<Target> targets = [];
  List<Recipe> recipes = [];

  addTarget() {
    var name = "";

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Create a target"),
              const SizedBox(height: 15),

              //  input box
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Target name",
                ),
                onChanged: (v) {
                  name = v;
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    targets.add(Target(name));
                  });
                },
                child: const Text("Add target"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addRecipe() {
    var name = "";

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Create a recipe"),
              const SizedBox(height: 15),

              //  input box
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Recipe name",
                ),
                onChanged: (v) {
                  name = v;
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    recipes.add(Recipe(name));
                  });
                },
                child: const Text("Add recipe"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  editTarget(context, e) {
    var route = MaterialPageRoute(
      builder: (context) => TargetPage(
        e,
        removeTarget: () {
          setState(() {
            targets.remove(e);
          });
        },
        renameTarget: (name) {
          setState(() {
            e.title = name;
          });
        },
        updateProgress: (n) {
          setState(() {
            e.progress += n;
          });
        },
      ),
    );

    Navigator.push(context, route);
  }

  editRecipe(context, e) {
    var route = MaterialPageRoute(
      builder: (context) => RecipePage(
        e,
        removeRecipe: () {
          setState(() {
            recipes.remove(e);
          });
        },
        renameRecipe: (name) {
          setState(() {
            e.title = name;
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
  Widget build(context) {
    final theme = Theme.of(context);
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
      body: [
        /// Home page
        Card(
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
        ),

        /// Targets page
        Scaffold(
          body: Card(
            margin: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: targets
                    .map(
                      (e) => ListTile(
                        title:
                            Text(e.title, style: const TextStyle(fontSize: 20)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${(e.progress * 100).floor()}% done"),
                            const SizedBox(height: 5),
                            LinearProgressIndicator(
                                value: e.progress, minHeight: 10),
                          ],
                        ),
                        onTap: () {
                          editTarget(context, e);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: addTarget,
            tooltip: "Add target",
            child: const Icon(Symbols.add),
          ),
        ),

        /// Recipes page
        Scaffold(
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
                            confirmation(context, "delete this recipe", () {
                              setState(() {
                                recipes.remove(e);
                              });
                            });
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
        ),

        /// Notifications page
        Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: notifications
                  .map(
                    (e) => Card(
                      child: ListTile(
                        leading: Icon(e.icon),
                        title: Text(e.title),
                        subtitle: Text(e.subtitle),
                        // show time as relative
                        trailing: Text(relativeTime(e.time)),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ][currentPageIndex],
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
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const Navigation(),
    );
  }
}

void main() => runApp(const App());
