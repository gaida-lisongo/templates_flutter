class SwitchingApi {
  final List<Map<String, dynamic>> _devices = [
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

  //Get All devices
  static Future<List<Map<String, dynamic>>> getAllDevices() async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));
    print("Fetching all devices from the Switching API");

    return SwitchingApi()._devices;
  }

  /// Simulates sending a command to switch a device on or off.
  static Future<bool> switchDevice(String deviceName, bool turnOn) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 3));

    // Here you would normally send a request to your backend or IoT device
    print("Device '$deviceName' has been turned ${turnOn ? 'ON' : 'OFF'}");

    //Find index of the device and update its status
    final deviceIndex = SwitchingApi()._devices.indexWhere(
      (device) => device["name"] == deviceName,
    );

    if (deviceIndex != -1) {
      SwitchingApi()._devices[deviceIndex]["powerStatus"] = turnOn
          ? "ON"
          : "OFF";
    }

    //Return the status of the device
    return turnOn;
  }

  // Get the current status of a device
  static Future<String> getDeviceStatus(String deviceName) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 3));

    //Find the device and return its status
    final device = SwitchingApi()._devices.firstWhere(
      (device) => device["name"] == deviceName,
      orElse: () => {},
    );

    final String status = device.isNotEmpty ? device["powerStatus"] : "OFF";
    print("Status of '$deviceName' is $status");

    return status;
  }
}
