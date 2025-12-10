import 'package:dashboard_ui/components/devices/devices_grid.dart';
import 'package:dashboard_ui/components/header/custom_appbar.dart';
import 'package:dashboard_ui/components/user/user_info.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          CustomAppbar(),
          SizedBox(height: 20.0),
          UserInfo(),
          SizedBox(height: 20.0),
          DevicesGrid(),
        ],
      ),
    );
  }
}
