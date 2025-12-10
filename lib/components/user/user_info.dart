import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0),
      children: [
        Text('Welcome Back,', style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 5.0),
        const Text(
          'John Doe',
          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
