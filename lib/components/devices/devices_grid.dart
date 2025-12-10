import 'package:dashboard_ui/components/common/device_card.dart';
import 'package:dashboard_ui/services/switching_api.dart';
import 'package:flutter/material.dart';

class DevicesGrid extends StatefulWidget {
  const DevicesGrid({super.key});

  @override
  State<DevicesGrid> createState() => _DevicesGridState();
}

class _DevicesGridState extends State<DevicesGrid> {
  final List<Map<String, dynamic>> _mySmartDevices = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _fetchDevices()
        .then((devices) {
          _isLoading = true;
          if (mounted) {
            setState(() {
              _mySmartDevices.addAll(devices);
            });
          }
        })
        .whenComplete(() => _loadDeviceStatuses());
    _loadDeviceStatuses();
  }

  Future<List<Map<String, dynamic>>> _fetchDevices() async {
    try {
      final devices = await SwitchingApi.getAllDevices();
      return devices;
    } catch (e) {
      print("Erreur lors de la récupération des dispositifs : $e");
      return [];
    }
  }

  Future<void> _loadDeviceStatuses() async {
    for (int i = 0; i < _mySmartDevices.length; i++) {
      final String deviceName = _mySmartDevices[i]["name"] ?? "";
      try {
        final String status = await SwitchingApi.getDeviceStatus(deviceName);
        if (mounted) {
          setState(() {
            _mySmartDevices[i]["powerStatus"] = status;
          });
        }
      } catch (e) {
        print("Erreur lors de la récupération du statut de $deviceName: $e");
        // Keep the local fallback value
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  Future<bool> _switchDevice(String deviceName, bool turnOn) async {
    try {
      // Simule une requête réseau pour changer le statut du dispositif
      final bool success = await SwitchingApi.switchDevice(deviceName, turnOn);

      return success;
    } catch (e) {
      print("Erreur lors du changement de statut de $deviceName: $e");
      return false;
    }
  }

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
        _isLoading
            ? const Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              )
            : Container(
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
                      powerStatus:
                          _mySmartDevices[index]["powerStatus"] ?? "OFF",
                      onChanged: (bool value) async {
                        final String deviceName =
                            _mySmartDevices[index]["name"] ?? "";

                        // Call the API to switch the device
                        final bool success = await _switchDevice(
                          deviceName,
                          value,
                        );

                        try {
                          print("API call success: $success");
                          // Update the local state only if the API call succeeded
                          setState(() {
                            _mySmartDevices[index]["powerStatus"] = success
                                ? "ON"
                                : "OFF";
                          });
                          print(
                            "Successfully switched $deviceName to ${value ? 'ON' : 'OFF'}",
                          );
                        } catch (e) {
                          print("Failed to switch $deviceName");
                          // Optionally, show a snackbar or dialog to the user
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "The device is on switch off: $deviceName",
                                ),
                              ),
                            );
                          }
                        }
                      },
                    );
                  },
                ),
              ),
      ],
    );
  }
}
