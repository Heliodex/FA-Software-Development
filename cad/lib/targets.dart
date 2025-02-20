import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "target.dart";

// Targets page
class Targets extends StatelessWidget {
  final ThemeData theme;
  final List<Target> targets;
  final void Function(BuildContext, Target) editTarget;
  final void Function() addTarget;
  const Targets(this.theme, this.targets, this.editTarget, this.addTarget,
      {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Card(
          margin: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: targets.isEmpty
                  ? [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "No targets found. Add a new target to get started!",
                            style: theme.textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ]
                  : targets
                      .map(
                        (e) => ListTile(
                          title: Text(e.title,
                              style: const TextStyle(fontSize: 20)),
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
      );
}
