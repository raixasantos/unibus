import 'package:flutter/material.dart';
import 'package:unibus/components/LoginProvider.dart';
import 'package:unibus/screens/login.dart';
import 'package:unibus/theme.dart';
import 'package:provider/provider.dart';

import 'components/CadastroProvider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CadastroProvider()),
    ChangeNotifierProvider(create: (context) => LoginProvider())
  ],
  child: MyApp(),
  ));
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
