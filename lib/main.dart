import 'package:flutter/material.dart';
import 'package:kudos/src/theme.dart';

import 'src/boot.dart';
import 'src/ui/route.dart';

void main() async {
  await boot();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Creator',
      theme: appTheme(context),
      initialRoute: '/',
      routes: routes(),
    );
  }
}
