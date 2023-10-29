import 'package:flutter/material.dart';
import 'package:unibus/screens/login.dart';
import 'package:unibus/theme.dart';
import 'package:provider/provider.dart';

import 'components/CadastroProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CadastroProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const Login(),
    );
  }
}
