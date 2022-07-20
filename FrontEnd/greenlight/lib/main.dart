import 'package:flutter/material.dart';
import 'package:greenlight/providers/posts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'ChatPage.dart';
import 'login.dart';
import 'main/mapPage.dart';
import 'main/boardPage.dart';
import 'mainPage.dart';
import 'signPage.dart';
import './main/postDetailPage.dart';
import './main/editPostPage.dart';
import './providers/posts.dart';
import 'providers/comments.dart';
import './providers/auth.dart';

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
    return ChangeNotifierProxyProvider<Auth, Posts>(
        create: (context)=> Posts('', '', []),
        update: (context, value, previous) => Posts(
          '',
          '',
          previous == null? [] : previous.items,
        ),

        child:
        MaterialApp(
        title: '그린라이트',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', 'KR'),
        ],
        locale: const Locale('ko'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MainPage(),
          '/login': (context) => LoginPage(),
          '/sign': (context) => SignPage(),
          '/map': (context) => MapPage(),
          '/chat': (context) => ChatPage(),
          '/board': (context) => BoardPage(),
          '/editPost': (context) => EditPostPage(),
          '/postDetail': (context) => PostDetailPage(),
        })
      );
    }
}