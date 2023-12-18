import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todoapp_uas/firebase_options.dart';
import 'package:flutter_todoapp_uas/view/menu_page.dart';
import 'package:flutter_todoapp_uas/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do List!',
        routes: {
          // '/home': (context) => const HomePage(),
          '/menu': (context) => const MenuPage(),
        },
        theme: ThemeData(),
        home: const SplashScreen(),
      ),
    ),
  );
}
