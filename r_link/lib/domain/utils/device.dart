import 'dart:developer';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class Device {
  String serviceUUID;
  String characteristicUUID;
  BluetoothDevice device;

  Device({
    required this.device,
    required this.characteristicUUID,
    required this.serviceUUID,
  });

  BluetoothService getService() {
    return device.servicesList.where((element) => element.uuid.str == serviceUUID).first;
  }

  BluetoothCharacteristic getCharacteristic() {
    return getService().characteristics.where((element) => element.uuid.str == characteristicUUID).first;
  }

  @override
  String toString() {
    return 'Device{serviceUUID: $serviceUUID, characteristicUUID: $characteristicUUID, device: $device}';
  }
}