import 'package:dfc_flutter/dfc_flutter.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:dfc_flutter/dfc_flutter.dart';
=======
>>>>>>> Stashed changes
import 'package:liquid_ui/home_screen.dart';
import 'package:liquid_ui/liquid_controller.dart';
import 'package:liquid_ui/mapper.g.dart' as mapper;
import 'package:provider/provider.dart';

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
