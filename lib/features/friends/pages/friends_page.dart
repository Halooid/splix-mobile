import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Friends')),
      body: ListView.builder(
        itemCount: 0, // TODO: Implement connection list
        itemBuilder: (context, index) {
          return const ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Friend Name'),
            subtitle: Text('No balance'),
          );
        },
      ),
    );
  }
}
