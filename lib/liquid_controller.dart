import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shared/flutter_shared.dart';
import 'package:liquid_ui/liquid_device.dart';
import 'package:liquid_ui/speed_menu.dart';

class LiquidController extends ChangeNotifier {
  LiquidController() {
    updateDevices();
  }

  String _result = '';
  int _exitCode = 0;
  final List<LiquidDevice> _devices = [];
  AnimationSpeedMenuItem _selectedItem = AnimationSpeedMenuItem.defaultMenuItem;

  // getters
  List<LiquidDevice> get devices => _devices;
  AnimationSpeedMenuItem get selectedItem => _selectedItem;
  set selectedItem(AnimationSpeedMenuItem item) {
    _selectedItem = item;

    notifyListeners();
  }

  String get result => _result;
  int get exitCode => _exitCode;

  Future<String> runCommand({
    LiquidDevice device,
    @required List<String> arguments,
    bool addSpeed = false,
  }) async {
    List<String> args = [];

    if (device != null) {
      args = [
        '--bus',
        device.bus,
        '--address',
        device.address,
      ];
    }

    if (addSpeed) {
      args.addAll([
        '--speed',
        Utils.enumToString(selectedItem.speed),
      ]);
    }

    args.addAll(arguments);
    print(args.join(' '));

    // liquidctl -d 1 set led color breathing 440022 002244
    // liquidctl -d 1 set led color fading 440022 002244

    final Process process = await Process.start('liquidctl', args);

    String output = '';

    final stream = process.stdout.transform(utf8.decoder);
    await stream.forEach((x) {
      output += x;
    });

    final errStream = process.stderr.transform(utf8.decoder);
    await errStream.forEach((x) {
      output += x;
    });

    // process.stdin.writeln('taro');

    _exitCode = await process.exitCode;
    _result = output;

    if (_result.firstChar == '[') {
      _result =
          StrUtils.toPrettyList(List<Map>.from(json.decode(_result) as List));
    }

    notifyListeners();

    return output;
  }

  Future<void> updateDevices() async {
    final result = await runCommand(arguments: ['list', '-v', '--json']);

    if (Utils.isNotEmpty(result)) {
      final List<Map<String, dynamic>> devices =
          List<Map<String, dynamic>>.from(json.decode(result) as List);

      _devices.clear();

      devices.forEach((e) {
        _devices.add(LiquidDevice.fromMap(e));
      });
    }

    notifyListeners();
  }

  Future<void> initialize(LiquidDevice device) async {
    await runCommand(arguments: [
      'initialize',
      '--bus',
      device.bus,
      '--address',
      device.address,
    ]);
  }

  Future<void> updateStatus() async {
    final status = await runCommand(arguments: [
      'status',
      '--json',
    ]);

    if (Utils.isNotEmpty(status)) {
      // fff

    }
  }

  // for NZXT case fans
  void setFanSpeed(LiquidDevice device, int speed) {
    runCommand(device: device, arguments: [
      'set',
      'sync',
      'speed',
      speed.toString(),
    ]);
  }
}
