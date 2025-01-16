import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "lib.dart";

class Milestone {
  String title;
  bool completed = false;
  Milestone(this.title);
}

class Target {
  String title;
  double progress = 0;
  List<Milestone> milestones = [];
  Target(this.title);
}

class TargetPageState extends State<TargetPage> {
  addMilestone() {
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
              const Text("Create a milestone"),
              const SizedBox(height: 15),

              //  input box
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Milestone name",
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
                    widget.e.milestones.add(Milestone(name));
                  });
                },
                child: const Text("Add milestone"),
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
          title: Text("Edit target: ${widget.e.title}"),
          // pencil icon to rename
          actions: [
            IconButton(
              icon: const Icon(Symbols.edit),
              onPressed: () {
                rename(context, "target", (name) {
                  setState(() {
                    widget.e.title = name;
                  });
                  widget.renameTarget(name);
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${(widget.e.progress * 100).floor()}% done"),
                  const SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: widget.e.progress,
                    minHeight: 10,
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),

            // milestones
            Column(
              children: widget.e.milestones
                  .map<ListTile>(
                    (m) => ListTile(
                      title: Text(m.title),
                      subtitle: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Incomplete"),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),

            // add milestone button
            ElevatedButton(
              onPressed: () {
                addMilestone();
              },
              child: const Text("Add milestone"),
            ),

            const SizedBox(height: 15),
            Column(
              children: [
                if (widget.e.progress < 1)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        widget.updateProgress(0.1);
                      });
                    },
                    child: const Text("Update progress"),
                  ),

                //   delete button
                ElevatedButton(
                  onPressed: () {
                    confirmation(context, "delete this target", () {
                      Navigator.pop(context);
                      setState(() {
                        widget.removeTarget();
                      });
                    });
                  },
                  child: const Text("Delete target"),
                ),
              ],
            ),
          ],
        ),
      );
}

class TargetPage extends StatefulWidget {
  final Target e;
  final Function() removeTarget;
  final Function(String) renameTarget;
  final Function(double) updateProgress;

  const TargetPage(this.e,
      {required this.removeTarget,
      required this.renameTarget,
      required this.updateProgress,
      super.key});

  @override
  createState() => TargetPageState();
}
