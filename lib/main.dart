import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unibus/components/LoginProvider.dart';
import 'package:unibus/components/NotificationProvider.dart';
import 'package:unibus/components/RouteProvider.dart';
import 'package:unibus/components/UserProvider.dart';
import 'package:unibus/firebase_options.dart';
import 'package:unibus/screens/login.dart';
import 'package:unibus/theme.dart';
import 'package:provider/provider.dart';

import 'components/CadastroProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CadastroProvider()),
      ChangeNotifierProvider(create: (context) => LoginProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => RouteProvider()),
      ChangeNotifierProvider(create: (context) => NotificationProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const Login(),
      navigatorKey: navigatorKey,
    );
  }
}
