import 'package:flutter/material.dart';
import 'package:flutter_shared/flutter_shared_web.dart';
import 'package:liquid_ui/liquid_controller.dart';
import 'package:liquid_ui/liquid_device.dart';
import 'package:provider/provider.dart';

class LiquidDeviceCard extends StatefulWidget {
  const LiquidDeviceCard({@required this.device});

  final LiquidDevice device;

  @override
  _LiquidDeviceCardState createState() => _LiquidDeviceCardState();
}

class _LiquidDeviceCardState extends State<LiquidDeviceCard> {
  double _fanSpeed = 0;

  Widget _buttonsForDevice(LiquidDevice device) {
    if (device.isNZXTSmartDevice) {
      return Column(
        children: [
          _nzxtButtons(),
          const SizedBox(height: 20),
          ..._nzxtCaseFanSlider(),
        ],
      );
    }

    return NothingWidget();
  }

  List<Widget> _nzxtCaseFanSlider() {
    final LiquidController lc = context.read<LiquidController>();

    return [
      const Text('Fan speed'),
      Slider(
        label: _fanSpeed.toInt().toString(),
        max: 100,
        divisions: 10,
        onChangeEnd: (value) {},
        onChanged: (value) {
          _fanSpeed = value;

          lc.setFanSpeed(widget.device.id, value.toInt());

          setState(() {});
        },
        value: _fanSpeed,
      )
    ];
  }

  Widget _nzxtButtons() {
    final LiquidController lc = context.read<LiquidController>();

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
    final LiquidController lc = context.read<LiquidController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListRow(
        leading: Icon(
          Icons.monetization_on_rounded,
          size: 44,
          color: Theme.of(context).primaryColor,
        ),
        title: widget.device.description,
        trailing: IconButton(
          onPressed: () {
            lc.initialize(widget.device.id);
          },
          icon: const Icon(
            Icons.ac_unit,
          ),
          tooltip: 'initialize',
        ),
        subWidget: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: _buttonsForDevice(widget.device),
        ),
      ),
    );
  }
}
