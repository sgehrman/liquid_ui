import 'package:flutter/material.dart';
import 'package:flutter_shared/flutter_shared_web.dart';
import 'package:liquid_ui/liquid_controller.dart';
import 'package:liquid_ui/liquid_device.dart';
import 'package:liquid_ui/two_colors.dart';
import 'package:provider/provider.dart';

class LiquidDeviceCard extends StatefulWidget {
  const LiquidDeviceCard({@required this.device});

  final LiquidDevice device;

  @override
  _LiquidDeviceCardState createState() => _LiquidDeviceCardState();
}

class _LiquidDeviceCardState extends State<LiquidDeviceCard> {
  double _fanSpeed = 0;
  Color _startColor;
  Color _endColor;

  Widget _buttonsForDevice(LiquidDevice device) {
    if (device.isNZXTSmartDevice) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          TwoColors(
            startColor: _startColor,
            endColor: _endColor,
            onChange: (start, end) {
              _startColor = start;
              _endColor = end;

              setState(() {});
            },
          ),
          const SizedBox(height: 20),
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

          lc.setFanSpeed(widget.device, value.toInt());

          setState(() {});
        },
        value: _fanSpeed,
      ),
    ];
  }

  Widget _nzxtButtons() {
    final LiquidController lc = context.read<LiquidController>();

    String startHex = _startColor != null
        ? _startColor.value.toRadixString(16)
        : Colors.white.value.toRadixString(16);
    String endHex = _endColor != null
        ? _endColor.value.toRadixString(16)
        : Colors.blue.value.toRadixString(16);

    startHex = startHex.substring(2);
    endHex = endHex.substring(2);

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '--bus',
              widget.device.bus,
              '--address',
              widget.device.address,
              'set',
              'led',
              'color',
              'breathing',
              startHex,
              endHex,
            ]);
          },
          child: const Text('Breathing'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '--bus',
              widget.device.bus,
              '--address',
              widget.device.address,
              'set',
              'led',
              'color',
              'fading',
              startHex,
              endHex,
            ]);
          },
          child: const Text('Fading'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '--bus',
              widget.device.bus,
              '--address',
              widget.device.address,
              'set',
              'led',
              'color',
              'fixed',
              startHex,
            ]);
          },
          child: const Text('Fixed Color'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '--bus',
              widget.device.bus,
              '--address',
              widget.device.address,
              'set',
              'led',
              'color',
              'spectrum-wave',
            ]);
          },
          child: const Text('Spectrum Wave'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '--bus',
              widget.device.bus,
              '--address',
              widget.device.address,
              'set',
              'led',
              'color',
              'candle',
              startHex,
            ]);
          },
          child: const Text('Candle'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '--bus',
              widget.device.bus,
              '--address',
              widget.device.address,
              'set',
              'led',
              'color',
              'wings',
              startHex,
            ]);
          },
          child: const Text('Wings'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '--bus',
              widget.device.bus,
              '--address',
              widget.device.address,
              'set',
              'led',
              'color',
              'alternating',
              startHex,
              endHex,
            ]);
          },
          child: const Text('alternating'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '--bus',
              widget.device.bus,
              '--address',
              widget.device.address,
              'set',
              'led',
              'color',
              'marquee-5',
              startHex,
            ]);
          },
          child: const Text('marquee'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '--bus',
              widget.device.bus,
              '--address',
              widget.device.address,
              'set',
              'led',
              'color',
              'super-fixed',
              startHex,
              endHex,
            ]);
          },
          child: const Text('Super Fixed'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '--bus',
              widget.device.bus,
              '--address',
              widget.device.address,
              'set',
              'led',
              'color',
              'off',
            ]);
          },
          child: const Text('Off'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              '--bus',
              widget.device.bus,
              '--address',
              widget.device.address,
              'set',
              'led',
              'color',
              'pulse',
              startHex,
              endHex,
            ]);
          },
          child: const Text('pulse'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final LiquidController lc = context.read<LiquidController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListRow(
        // leading: Icon(
        //   Icons.monetization_on_rounded,
        //   size: 44,
        //   color: Theme.of(context).primaryColor,
        // ),
        title: widget.device.description,
        trailing: IconButton(
          onPressed: () {
            lc.initialize(widget.device);
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
