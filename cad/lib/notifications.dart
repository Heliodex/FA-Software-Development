import "package:flutter/material.dart";
import "lib.dart";

class AppNotification {
  var icon = Icons.notifications;
  var title = "", subtitle = "";
  var time = DateTime.now();
  AppNotification(this.icon, this.title, this.subtitle, this.time);

  AppNotification.fromJson(Map<String, dynamic> decoded) {
    icon = IconData(decoded["icon"], fontFamily: "MaterialIcons");
    title = decoded["title"];
    subtitle = decoded["subtitle"];
    time = DateTime.parse(decoded["time"]);
  }

  toJson() => {
        "icon": icon.codePoint,
        "title": title,
        "subtitle": subtitle,
        "time": time.toIso8601String(),
      };
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
