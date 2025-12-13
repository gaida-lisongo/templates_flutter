import 'package:dashboard_ui/components/categories.dart';
import 'package:dashboard_ui/components/user_info.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.indigo,
          child: Column(children: [UserInfo(), Categories()]),
        ),
      ),
    );
  }
}
