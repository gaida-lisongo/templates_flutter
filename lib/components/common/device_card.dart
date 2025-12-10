import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceCard extends StatefulWidget {
  final String iconDevice;
  final String deviceName;
  final String powerStatus;
  final Future<void> Function(bool) onChanged;

  const DeviceCard({
    super.key,
    required this.iconDevice,
    required this.deviceName,
    required this.powerStatus,
    required this.onChanged,
  });

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.powerStatus == 'OFF'
            ? Colors.grey[200]
            : Colors.grey[900],
        borderRadius: BorderRadius.circular(24.0),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            widget.iconDevice,
            height: 64.0,
            width: 64.0,
            color: widget.powerStatus == 'OFF' ? Colors.black : Colors.white,
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    widget.deviceName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: widget.powerStatus == 'OFF'
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
              Transform.rotate(
                angle: pi / 2,
                child: _isLoading
                    ? SizedBox(
                        width: 40,
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              widget.powerStatus == 'OFF'
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      )
                    : CupertinoSwitch(
                        value: widget.powerStatus == 'ON' ? true : false,
                        onChanged: _isLoading
                            ? null
                            : (bool value) async {
                                setState(() => _isLoading = true);
                                try {
                                  await widget.onChanged(value);
                                } finally {
                                  if (mounted) {
                                    setState(() => _isLoading = false);
                                  }
                                }
                              },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
