import 'package:dfc_flutter/dfc_flutter.dart';
import 'package:flutter/material.dart';
import 'package:liquid_ui/liquid_controller.dart';
import 'package:liquid_ui/liquid_device.dart';
import 'package:liquid_ui/speed_menu.dart';
import 'package:liquid_ui/two_colors.dart';
import 'package:provider/provider.dart';

class LiquidDeviceCard extends StatefulWidget {
  const LiquidDeviceCard({required this.device});

  final LiquidDevice device;

  @override
  _LiquidDeviceCardState createState() => _LiquidDeviceCardState();
}

class _LiquidDeviceCardState extends State<LiquidDeviceCard> {
  double _fanSpeed = 0;
  Color? _startColor = Colors.cyan;
  Color? _endColor = Colors.pink;

  Widget _buttonsForDevice() {
    if (widget.device.isNZXTSmartDeviceV1 ||
        widget.device.isNZXTSmartDeviceV2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          TwoColors(
            startColor: _startColor,
            endColor: _endColor,
            onChange: (start, end) {
              _startColor = start ?? Colors.cyan;
              _endColor = end ?? Colors.pink;

              setState(() {});
            },
          ),
          const SizedBox(height: 20),
          _nzxtButtons(),
          const SizedBox(height: 20),
          ..._nzxtCaseFanSlider(),
        ],
      );
    } else if (widget.device.isNZXTKraken) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          TwoColors(
            startColor: _startColor,
            endColor: _endColor,
            onChange: (start, end) {
              _startColor = start ?? Colors.cyan;
              _endColor = end ?? Colors.pink;

              setState(() {});
            },
          ),
          const SizedBox(height: 20),
          _krakenButtons(),
        ],
      );
    }

    return const NothingWidget();
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

  List<CommandSpec> _commands() {
    final List<CommandSpec> result = [];

    String startHex = _startColor != null
        ? _startColor!.value.toRadixString(16)
        : Colors.white.value.toRadixString(16);
    String endHex = _endColor != null
        ? _endColor!.value.toRadixString(16)
        : Colors.blue.value.toRadixString(16);

    startHex = startHex.substring(2);
    endHex = endHex.substring(2);

    String channel = 'led';

    if (widget.device.isNZXTSmartDeviceV2) {
      channel = 'sync';
    }

    result.add(
      CommandSpec(
        name: 'Breathing',
        addSpeed: true,
        arguments: [
          'set',
          channel,
          'color',
          'breathing',
          startHex,
          endHex,
        ],
      ),
    );

    result.add(
      CommandSpec(
        name: 'Fading',
        addSpeed: true,
        arguments: [
          'set',
          channel,
          'color',
          'fading',
          startHex,
          endHex,
        ],
      ),
    );

    result.add(
      CommandSpec(
        name: 'Fixed',
        arguments: [
          'set',
          channel,
          'color',
          'fixed',
          startHex,
        ],
      ),
    );

    result.add(
      CommandSpec(
        name: 'Spectrum Wave',
        arguments: [
          'set',
          channel,
          'color',
          'spectrum-wave',
        ],
        addSpeed: true,
      ),
    );

    result.add(
      CommandSpec(
        name: 'Candle',
        addSpeed: true,
        arguments: [
          'set',
          channel,
          'color',
          'candle',
          startHex,
        ],
      ),
    );

    result.add(
      CommandSpec(
        name: 'Alternating',
        addSpeed: true,
        arguments: [
          'set',
          channel,
          'color',
          'alternating',
          startHex,
          endHex,
        ],
      ),
    );

    result.add(
      CommandSpec(
        name: 'Marquee',
        addSpeed: true,
        arguments: [
          'set',
          channel,
          'color',
          'marquee-5',
          startHex,
        ],
      ),
    );

    result.add(
      CommandSpec(
        name: 'Super Fixed',
        arguments: [
          'set',
          channel,
          'color',
          'super-fixed',
          startHex,
          endHex,
        ],
      ),
    );

    result.add(
      CommandSpec(
        name: 'Off',
        arguments: [
          'set',
          channel,
          'color',
          'off',
        ],
      ),
    );

    result.add(
      CommandSpec(
        name: 'Pulse',
        addSpeed: true,
        arguments: [
          'set',
          channel,
          'color',
          'pulse',
          startHex,
          endHex,
        ],
      ),
    );

    if (widget.device.isNZXTSmartDeviceV1) {
      result.add(
        CommandSpec(
          name: 'Wings',
          addSpeed: true,
          arguments: [
            'set',
            channel,
            'color',
            'wings',
            startHex,
          ],
        ),
      );
    }

    if (widget.device.isNZXTSmartDeviceV2) {
      // sdf
    }

    return result;
  }

  List<Widget> _buttons() {
    final LiquidController lc = context.read<LiquidController>();

    return _commands().map((cmd) {
      return ElevatedButton(
        onPressed: () async {
          await lc.runCommand(
            device: widget.device,
            addSpeed: cmd.addSpeed,
            arguments: cmd.arguments,
          );
        },
        child: Text(cmd.name),
      );
    }).toList();
  }

  Widget _nzxtButtons() {
    final LiquidController lc = context.read<LiquidController>();

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        AnimationSpeedMenu(
          selectedItem: lc.selectedItem,
          onItemSelected: (selected) {
            lc.selectedItem = selected;
          },
        ),
        ..._buttons(),
      ],
    );
  }

  Widget _krakenButtons() {
    final LiquidController lc = context.read<LiquidController>();

    String startHex = _startColor != null
        ? _startColor!.value.toRadixString(16)
        : Colors.white.value.toRadixString(16);
    String endHex = _endColor != null
        ? _endColor!.value.toRadixString(16)
        : Colors.blue.value.toRadixString(16);

    startHex = startHex.substring(2);
    endHex = endHex.substring(2);

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        AnimationSpeedMenu(
          selectedItem: lc.selectedItem,
          onItemSelected: (selected) {
            lc.selectedItem = selected;
          },
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand(
              device: widget.device,
              addSpeed: true,
              arguments: [
                'set',
                'logo',
                'color',
                'fixed',
                startHex,
              ],
            );
          },
          child: const Text('Logo Fixed'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand(
              device: widget.device,
              addSpeed: true,
              arguments: [
                'set',
                'ring',
                'color',
                'loading',
                startHex,
              ],
            );
          },
          child: const Text('Ring Loading'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand(
              device: widget.device,
              addSpeed: true,
              arguments: [
                'set',
                'ring',
                'color',
                'loading',
                startHex,
              ],
            );
          },
          child: const Text('Ring Loading'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand(
              device: widget.device,
              addSpeed: true,
              arguments: [
                'set',
                'ring',
                'color',
                'spectrum-wave',
              ],
            );
          },
          child: const Text('Ring Spectrum Wave'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand(
              device: widget.device,
              addSpeed: true,
              arguments: [
                'set',
                'logo',
                'color',
                'spectrum-wave',
              ],
            );
          },
          child: const Text('Logo Spectrum Wave'),
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
          child: _buttonsForDevice(),
        ),
      ),
    );
  }
}

class CommandSpec {
  CommandSpec({
    required this.name,
    required this.arguments,
    this.addSpeed = false,
  });

  final String name;
  final bool addSpeed;
  final List<String> arguments;
}
