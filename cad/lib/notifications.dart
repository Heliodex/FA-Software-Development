import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "lib.dart";

class AppNotification {
  var icon = Icons.notifications;
  var title = "", subtitle = "";
  var time = DateTime.now();
  AppNotification(this.icon, this.title, this.subtitle, this.time);

  AppNotification.fromJson(Map<String, dynamic> decoded) {
    icon = Symbols.target;
    title = decoded["title"];
    subtitle = decoded["subtitle"];
    time = DateTime.parse(decoded["time"]);
  }

  toJson() => {
        // "icon": icon.codePoint,
        "title": title,
        "subtitle": subtitle,
        "time": time.toIso8601String(),
      };
}

// Notifications page
class NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: widget.notifications.isEmpty
                ? [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "No notifications yet.",
                          style: widget.theme.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ]
                : (widget.notifications
                      ..sort((a, b) => b.time.compareTo(a.time)))
                    .map(
                      (e) => Dismissible(
                        key: Key(e.time.toIso8601String()),
                        onDismissed: (direction) {
                          setState(() {
                            widget.deleteNotification(e);
                          });
                        },
                        background: Container(color: Colors.red),
                        child: Card(
                          child: ListTile(
                            leading: Icon(e.icon),
                            title: Text(e.title),
                            subtitle: Text(e.subtitle),
                            // show time as relative
                            trailing: Text(relativeTime(e.time)),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      );
}

class Notifications extends StatefulWidget {
  final ThemeData theme;
  final List<AppNotification> notifications;
  final Function(AppNotification) deleteNotification;
  const Notifications(this.theme, this.notifications, this.deleteNotification,
      {super.key});

  @override
  NotificationsState createState() => NotificationsState();
}
