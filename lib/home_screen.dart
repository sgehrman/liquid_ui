import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:liquid_ui/liquid_controller.dart';
import 'package:liquid_ui/liquid_device_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    @required this.title,
  });

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _deviceList() {
    final LiquidController lc = context.watch<LiquidController>();

    final keys = lc.devices.keys.toList();

    return ListView.builder(
      itemCount: keys.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final key = keys[index];

        return LiquidDeviceCard(
          device: lc.devices[key],
        );
      },
    );
  }

  Widget _buttons() {
    final LiquidController lc = context.watch<LiquidController>();

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ElevatedButton(
          onPressed: () async {
            await lc.updateDevices();
          },
          child: const Text('List'),
        ),
        ElevatedButton(
          onPressed: () async {
            await lc.runCommand([
              'status',
            ]);
          },
          child: const Text('Status'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final LiquidController lc = context.watch<LiquidController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 60, top: 20),
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buttons(),
              const SizedBox(height: 20),
              _deviceList(),
              const SizedBox(height: 20),
              const Text(
                'Results',
              ),
              const SizedBox(height: 10),
              Text(
                lc.result ?? 'none',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
