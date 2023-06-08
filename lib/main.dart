import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'main_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
DatabaseReference CatClients = FirebaseDatabase.instance.ref().child("Clients");
DatabaseReference Farms = FirebaseDatabase.instance.ref().child("Farms");
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Farms',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const Expenses(),
    );
  }
}


