import "package:flutter/material.dart";
import "lib.dart";

class AppNotification {
  IconData icon;
  String title, subtitle;
  DateTime time;
  AppNotification(this.icon, this.title, this.subtitle, this.time);
}

// Notifications page
class Notifications extends StatelessWidget {
  final ThemeData theme;
  final List<AppNotification> notifications;
  const Notifications(this.theme, this.notifications, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
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
      );
}
