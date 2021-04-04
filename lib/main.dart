import 'package:flutter/material.dart';
import 'package:flutter_shared/flutter_shared.dart';
import 'package:liquid_ui/home_screen.dart';
import 'package:liquid_ui/liquid_controller.dart';
import 'package:provider/provider.dart';
import 'mapper.g.dart' as mapper;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  mapper.init();

  await HiveUtils.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue[800],
      scaffoldBackgroundColor: const Color.fromRGBO(0, 22, 42, 1),
      brightness: Brightness.dark,
      visualDensity: VisualDensity.standard,
      textTheme: const TextTheme(
        bodyText1: TextStyle(fontSize: 20),
        bodyText2: TextStyle(fontSize: 20),
        caption: TextStyle(fontSize: 18),
        headline6: TextStyle(fontSize: 20),
        headline5: TextStyle(fontSize: 20),
        headline4: TextStyle(fontSize: 20),
        subtitle1: TextStyle(fontSize: 20),
        overline: TextStyle(fontSize: 20),
        button: TextStyle(fontSize: 20),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Preferences()),
        ChangeNotifierProvider(create: (context) => LiquidController()),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'Liquidctl UI',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const HomeScreen(title: 'Liquidctl UI'),
        ),
      ),
    );
  }
}
