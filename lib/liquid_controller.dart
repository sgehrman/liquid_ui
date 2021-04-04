import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shared/flutter_shared.dart';
import 'package:liquid_ui/liquid_device.dart';

// Device ID 0: NZXT Kraken X (X42, X52, X62 or X72)
// ├── Vendor ID: 0x1e71
// ├── Product ID: 0x170e
// ├── Release number: 0x0200
// ├── Serial number: 87815F83525
// ├── Bus: hid
// ├── Address: /dev/hidraw4
// └── Driver: Kraken2

// Device ID 1: NZXT Smart Device (V1)
// ├── Vendor ID: 0x1e71
// ├── Product ID: 0x1714
// ├── Release number: 0x0200
// ├── Serial number: 6D811F7A5055
// ├── Bus: hid
// ├── Address: /dev/hidraw5
// └── Driver: SmartDevice

class LiquidController extends ChangeNotifier {
  LiquidController() {
    updateDevices();
  }

  String _result = '';
  int _exitCode = 0;
  final List<LiquidDevice> _devices = [];

  List<LiquidDevice> get devices => _devices;
  String get result => _result;
  int get exitCode => _exitCode;

  Future<String> runCommand(
    List<String> arguments,
  ) async {
    print(arguments.join(' '));

    // liquidctl -d 1 set led color breathing 440022 002244
    // liquidctl -d 1 set led color fading 440022 002244

    final Process process = await Process.start('liquidctl', arguments);

    final stream = process.stdout.transform(utf8.decoder);

    String output = '';
    await stream.forEach((x) {
      output += x;
    });

    // process.stdin.writeln('taro');

    _exitCode = await process.exitCode;
    _result = output;

    notifyListeners();

    return output;
  }

  Future<void> updateDevices() async {
    final result = await runCommand(['list', '-v', '--json']);

    if (Utils.isNotEmpty(result)) {
      final List<Map<String, dynamic>> devices =
          List<Map<String, dynamic>>.from(json.decode(result) as List);

      devices.forEach((e) {
        _devices.add(LiquidDevice.fromMap(e));
      });
    }

    notifyListeners();
  }

  Future<void> initialize(LiquidDevice device) async {
    await runCommand([
      'initialize',
      '--bus',
      device.bus,
      '--address',
      device.address,
    ]);
  }

  Future<void> updateStatus() async {
    final status = await runCommand([
      'status',
      '--json',
    ]);

    if (Utils.isNotEmpty(status)) {
      // flutter: NZXT Kraken X (X42, X52, X62 or X72)
      // ├── Liquid temperature     29.8  °C
      // ├── Fan speed               979  rpm
      // ├── Pump speed             2141  rpm
      // └── Firmware version      4.0.2
      // NZXT Smart Device (V1)
      // ├── Fan 1                          —
      // ├── Fan 2                         DC
      // ├── Fan 2 current               0.05  A
      // ├── Fan 2 speed                  727  rpm
      // ├── Fan 2 voltage               4.38  V
      // ├── Fan 3                         DC
      // ├── Fan 3 current               0.06  A
      // ├── Fan 3 speed                  712  rpm
      // ├── Fan 3 voltage               4.24  V
      // ├── Firmware version           1.0.7
      // ├── LED accessories                2
      // ├── LED accessory type    HUE+ Strip
      // ├── LED count (total)             20
      // └── Noise level                   57  dB

    }
  }

  // for NZXT case fans
  void setFanSpeed(LiquidDevice device, int speed) {
    runCommand([
      '--bus',
      device.bus,
      '--address',
      device.address,
      'set',
      'sync',
      'speed',
      speed.toString(),
    ]);
  }
}
