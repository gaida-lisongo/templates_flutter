import 'package:dashboard_ui/components/common/device_card.dart';
import 'package:flutter/material.dart';

class DevicesGrid extends StatefulWidget {
  const DevicesGrid({super.key});

  @override
  State<DevicesGrid> createState() => _DevicesGridState();
}

class _DevicesGridState extends State<DevicesGrid> {
  final List<Map<String, String>> _mySmartDevices = [
    {
      "name": "Smart Light",
      "iconPath": "assets/images/light-bulb.png",
      "powerStatus": "OFF",
    },
    {
      "name": "Smart AC",
      "iconPath": "assets/images/ac.png",
      "powerStatus": "OFF",
    },
    {
      "name": "Smart TV",
      "iconPath": "assets/images/tv.png",
      "powerStatus": "ON",
    },
    {
      "name": "Smart Fan",
      "iconPath": "assets/images/fan.png",
      "powerStatus": "OFF",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'My Smart Devices',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Text('IoT'),
            ],
          ),
        ),

        // J'ai retiré le Expanded ici !
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          // Le GridView va maintenant calculer sa propre hauteur
          child: GridView.builder(
            itemCount: _mySmartDevices.length,
            // 1. IMPORTANT : shrinkWrap permet au GridView de prendre juste la place nécessaire
            shrinkWrap: true,
            // 2. IMPORTANT : Empêche le GridView de scroller lui-même (c'est la page qui scrollera)
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio:
                  1 /
                  1.3, // Optionnel : ajuste le ratio hauteur/largeur des cartes
            ),
            itemBuilder: (context, index) {
              return DeviceCard(
                iconDevice: _mySmartDevices[index]["iconPath"] ?? "",
                deviceName: _mySmartDevices[index]["name"] ?? "",
                powerStatus: _mySmartDevices[index]["powerStatus"] ?? "",
                onChanged: (bool value) {
                  print(
                    "Switch toggled for ${_mySmartDevices[index]["name"]}: $value",
                  );

                  setState(() {
                    _mySmartDevices[index]["powerStatus"] = value
                        ? "ON"
                        : "OFF";
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
