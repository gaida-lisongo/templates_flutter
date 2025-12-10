import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              print("Menu button pressed");
            },
            icon: const Icon(Icons.menu),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              print("Profile button pressed");
            },
          ),
        ],
      ),
    );
  }
}
