import 'package:flutter/material.dart';
import '/screens/homescreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const String title = 'To do';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
          primaryColorDark: Colors.black,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.blue,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: const Homescreen(),
        routes: {
          'homescreen': (context) => const Homescreen(),
        },
      );
}
