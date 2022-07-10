import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'login.dart';
import 'main/mapPage.dart';
import 'mainPage.dart';
import 'signPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Future<Database> initDatabase() async {
  //   return openDatabase(
  //     join(await getDatabasesPath(), 'bank_database.db'),
  //     onCreate: (db, version) {
  //       return db.execute(
  //         "CREATE TABLE place(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, tel TEXT , zipcode TEXT , address TEXT , lat Number , lng Number , imagePath TEXT, organName TEXT, organVolumn Number)",
  //       );
  //     },
  //     version: 1,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // Future<Database> database = initDatabase(); // build 할때 initDatabase() 함수를 호출
    return MaterialApp(
      title: '그린라이트',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/login': (context) => LoginPage(),
        '/sign': (context) => SignPage(),
        '/map': (context) => MapPage(),
      },);}
}