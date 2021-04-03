import 'package:flutter/material.dart';
import 'package:flutter_shared/flutter_shared.dart';
import 'package:liquid_ui/home_screen.dart';
import 'package:liquid_ui/liquid_controller.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveUtils.init(); // test

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Preferences()),
        ChangeNotifierProvider(create: (context) => LiquidController()),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'Liquidctl UI',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(title: 'Liquidctl UI'),
        ),
      ),
    );
  }
}
