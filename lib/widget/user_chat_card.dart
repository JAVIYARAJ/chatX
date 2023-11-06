import 'package:flutter/material.dart';
class UserChatCard extends StatelessWidget {
  const UserChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset("assets/images/ic_profile_icon.png"),
      title: Text("Javiya raj"),
      subtitle: Text("hi"),
      trailing: Text("10:00 AM"),
    );
  }
}
