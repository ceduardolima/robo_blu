import 'package:r_link/domain/utils/device.dart';

class GlobalDevice {
  static Device? _device;

  static setDevice(Device device)  {
    _device = device;
  }

  static Device? get device => _device;
}