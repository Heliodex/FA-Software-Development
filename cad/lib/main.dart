import "package:flutter/material.dart";

class NavigationState extends State<Navigation> {
  var currentPageIndex = 0;
  var counter = 0;

  incrementCounter() {
    setState(() {
      counter++;
    });
  }

  destinationSelected(index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.purple[900],
        onDestinationSelected: destinationSelected,
        indicatorColor: Colors.purpleAccent[700],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: "Notifications",
          ),
        ],
      ),
      body: [
        /// Home page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Home page",
                  style: theme.textTheme.titleLarge,
                ),
                const Text(
                  "Basic counter application nerd",
                ),
                Text(
                  "Number $counter",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text("Notification 1"),
                  subtitle: Text("Bitcoin button"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text("Notification 2"),
                  subtitle: Text("Increment from anywhere"),
                ),
              ),
            ],
          ),
        ),
      ][currentPageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        tooltip: "Increment",
        child: const Icon(Icons.currency_bitcoin),
      ),
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
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const Navigation(),
    );
  }
}

void main() => runApp(const App());
