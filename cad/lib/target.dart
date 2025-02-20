import "package:cad/data.dart";
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
              widget.e.milestones.add(Milestone(name));
              updateTarget(widget.e);
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
                rename(context, "target", (name) {
                  setState(() {
                    widget.e.title = name;
                    updateTarget(widget.e);
                  });
                  widget.renameTarget(name);
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
                          widget.e.milestones.remove(m);
                          if (widget.e.completed >
                              widget.e.milestones.indexOf(m)) {
                            widget.e.completed--;
                          }
                          updateTarget(widget.e);
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
                      widget.e.completed--;
                      updateTarget(widget.e);
                    });
                  }
                },
                child: const Text("Undo milestone"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget.e.completed < widget.e.milestones.length) {
                    setState(() {
                      widget.e.completed++;
                      updateTarget(widget.e);
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
            // if (widget.e.progress < 1)
            //   ElevatedButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //       setState(() {
            //         widget.updateProgress(0.1);
            //       });
            //     },
            //     child: const Text("Update progress"),
            //   ),

            // delete button
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
          ]),
        ]),
      );
}

class TargetPage extends StatefulWidget {
  final Target e;
  final Function() removeTarget;
  final Function(String) renameTarget;

  const TargetPage(this.e,
      {required this.removeTarget, required this.renameTarget, super.key});

  @override
  createState() => TargetPageState();
}
