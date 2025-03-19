import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "lib.dart";

class Milestone {
  String title;
  Milestone(this.title);
}

class Target {
  var title = "";
  List<Milestone> milestones = [];
  var completed = 0;
  Target(this.title);

  Target.fromJson(Map<String, dynamic> decoded) {
    title = decoded["title"];
    completed = decoded["completed"];
    for (var m in decoded["milestones"]) {
      milestones.add(Milestone(m));
    }
  }

  toJson() => {
        "title": title,
        "completed": completed,
        "milestones": milestones.map((m) => m.title).toList(),
      };

  double get progress {
    if (milestones.isEmpty) return 0;
    return completed / milestones.length;
  }
}

class TargetPageState extends State<TargetPage> {
  addMilestone() {
    var name = "";

    dialog(
      context,
      "Create a milestone",
      [
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Milestone name",
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
              widget.addMilestone(Milestone(name));
            });
          },
          child: const Text("Add milestone"),
        ),
      ],
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
                rename(context, widget.e.title, "target", (name) {
                  setState(() {
                    widget.renameTarget(name);
                  });
                });
              },
            ),
          ],
        ),
        body: Column(children: [
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.e.milestones.indexOf(m) < widget.e.completed
                            ? "Complete"
                            : "Incomplete"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Symbols.delete),
                      onPressed: () {
                        setState(() {
                          widget.removeMilestone(m);
                        });
                      },
                    ),
                  ),
                )
                .toList(),
          ),

          // side-by-side increase and decrease progress buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (widget.e.completed > 0) {
                    setState(() {
                      widget.updateMilestone(-1);
                    });
                  }
                },
                child: const Text("Undo milestone"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget.e.completed < widget.e.milestones.length) {
                    setState(() {
                      widget.updateMilestone(1);
                    });
                  }
                },
                child: const Text("Complete milestone"),
              ),
            ],
          ),

          // add milestone button
          ElevatedButton(
            onPressed: addMilestone,
            child: const Text("Add milestone"),
          ),

          const SizedBox(height: 15),
          Column(children: [
            // delete button
            ElevatedButton(
              onPressed: () {
                confirmation(context, "delete this target", () {
                  Navigator.pop(context);
                  widget.removeTarget();
                });
              },
              child: const Text("Delete target"),
            ),
          ]),
        ]),
      );
}

class TargetPage extends StatefulWidget {
  final Target e;
  final Function() removeTarget;
  final Function(String) renameTarget;
  final Function(int) updateMilestone;
  final Function(Milestone) removeMilestone;
  final Function(Milestone) addMilestone;

  const TargetPage(this.e,
      {required this.removeTarget,
      required this.renameTarget,
      required this.updateMilestone,
      required this.removeMilestone,
      required this.addMilestone,
      super.key});

  @override
  createState() => TargetPageState();
}
