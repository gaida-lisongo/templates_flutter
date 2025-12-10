import 'dart:math';

class SwitchingApi {
  /// Simulates sending a command to switch a device on or off.
  static Future<bool> switchDevice(String deviceName, bool turnOn) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    // Here you would normally send a request to your backend or IoT device
    print("Device '$deviceName' has been turned ${turnOn ? 'ON' : 'OFF'}");

    //Reponse aléatoire en true pour simuler le succès de l'opération
    if (DateTime.now().second % 2 == 0) {
      return false;
    } else {
      return true;
    }
  }

  // Get the current status of a device
  static Future<String> getDeviceStatus(String deviceName) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    // Here you would normally fetch the status from your backend or IoT device
    // For demonstration, we'll randomly return "ON" or "OFF"
    final status = (DateTime.now().second % 2 == 0) ? "ON" : "OFF";
    print("Device '$deviceName' is currently $status");

    return status;
  }
}
