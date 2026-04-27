import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Groups')),
      body: ListView.builder(
        itemCount: 0, // TODO: Implement groups list
        itemBuilder: (context, index) {
          return const ListTile(
            leading: CircleAvatar(child: Icon(Icons.group)),
            title: Text('Group Name'),
            subtitle: Text('No active expenses'),
          );
        },
      ),
    );
  }
}
