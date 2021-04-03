import 'package:flutter/material.dart';
import 'package:flutter_shared/flutter_shared_web.dart';
import 'package:liquid_ui/liquid_controller.dart';
import 'package:provider/provider.dart';

class LiquidDeviceCard extends StatefulWidget {
  const LiquidDeviceCard({@required this.device});

  final LiquidDevice device;

  @override
  _LiquidDeviceCardState createState() => _LiquidDeviceCardState();
}

class _LiquidDeviceCardState extends State<LiquidDeviceCard> {
  Widget _buttonsForDevice(LiquidDevice device) {
    if (device.isNZXTSmartDevice) {
      return _nzxtButtons();
    }

    return NothingWidget();
  }

  Widget _nzxtButtons() {
    final LiquidController lc = context.watch<LiquidController>();

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '-d',
              widget.device.id,
              'set',
              'sync',
              'speed',
              '0',
            ]);
          },
          child: const Text('Fan Off'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '-d',
              widget.device.id,
              'set',
              'sync',
              'speed',
              '10',
            ]);
          },
          child: const Text('Fan Slow'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '-d',
              widget.device.id,
              'set',
              'sync',
              'speed',
              '90',
            ]);
          },
          child: const Text('Fan Fast'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '-d',
              widget.device.id,
              'set',
              'led',
              'color',
              'breathing',
              '440022',
              '002244'
            ]);
          },
          child: const Text('Breathing'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '-d',
              widget.device.id,
              'set',
              'led',
              'color',
              'fading',
              '440022',
              '002244'
            ]);
          },
          child: const Text('Fading'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '-d',
              widget.device.id,
              'set',
              'led',
              'color',
              'breathing',
              '140022',
              '442200'
            ]);
          },
          child: const Text('wak'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final LiquidController lc = context.watch<LiquidController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.monetization_on_rounded, size: 44),
        title: Text(widget.device.description),
        trailing: IconButton(
          onPressed: () {
            lc.initialize(widget.device.id);
          },
          icon: const Icon(Icons.ac_unit),
        ),
        subtitle: _buttonsForDevice(widget.device),
      ),
    );
  }
}
