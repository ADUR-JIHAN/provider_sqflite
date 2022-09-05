import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/providers/user_notifier.dart';
import 'package:provider_demo/screens/home.dart';
import 'package:provider_demo/sqlflite_database/database_helper.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper();
  runApp(
      MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => ListNotifier()),],
          child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
      },
    );
  }
}
