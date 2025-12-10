import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String iconDevice;
  final String deviceName;
  final String powerStatus;
  final void Function(bool) onChanged;

  const DeviceCard({
    super.key,
    required this.iconDevice,
    required this.deviceName,
    required this.powerStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: powerStatus == 'OFF' ? Colors.grey[200] : Colors.grey[900],
        borderRadius: BorderRadius.circular(24.0),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconDevice,
            height: 64.0,
            width: 64.0,
            color: powerStatus == 'OFF' ? Colors.black : Colors.white,
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    deviceName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: powerStatus == 'OFF' ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
              Transform.rotate(
                angle: pi / 2,
                child: CupertinoSwitch(
                  value: powerStatus == 'ON' ? true : false,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
