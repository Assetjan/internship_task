import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_wall/auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_wall/models/album_provider.dart';
import 'package:social_wall/pages/album_page.dart';
import 'package:social_wall/pages/each_album_page.dart';
import 'package:social_wall/pages/to_do_page.dart';
import 'package:social_wall/pages/user_cabinet_page.dart';
import 'package:social_wall/pages/users_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AlbumProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      routes: {
        '/user_cabinet_page': (context) => UserCabinetPage(),
        '/album_page': (context) => AlbumPage(),
        '/each_album_page': (context) => EachAlbumPage(),
        '/to_do_page': (context) => ToDoPage(),
        '/users_page': (context) => UsersPage(),
      },
    );
  }
}
