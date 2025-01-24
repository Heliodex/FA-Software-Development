import "package:flutter/material.dart";

relativeTime(t) {
  var now = DateTime.now();
  var diff = now.difference(t);

  if (diff.inDays > 365) {
    return "${diff.inDays ~/ 365} years ago";
  } else if (diff.inDays > 30) {
    return "${diff.inDays ~/ 30} months ago";
  } else if (diff.inDays > 0) {
    return "${diff.inDays} days ago";
  } else if (diff.inHours > 0) {
    return "${diff.inHours} hours ago";
  } else if (diff.inMinutes > 0) {
    return "${diff.inMinutes} minutes ago";
  }
  return "${diff.inSeconds} seconds ago";
}

dialog(BuildContext context, String title, List<Widget> inputs,
        List<Widget> buttons) =>
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title),
              const SizedBox(height: 15),
              ...inputs,
              const SizedBox(height: 15),
              ...buttons,
            ],
          ),
        ),
      ),
    );

confirmation(BuildContext context, m, ifConfirm) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure you want to $m?"),
        content: const Text("This action cannot be undone"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ifConfirm();
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );

rename(context, thing, onPressed) {
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
            Text("Rename $thing"),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText:
                    "${thing[0].toUpperCase() + thing.substring(1)} name",
              ),
              onChanged: (v) {
                name = v;
              },
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onPressed(name);
              },
              child: Text("Rename $thing"),
            ),
          ],
        ),
      ),
    ),
  );
}
