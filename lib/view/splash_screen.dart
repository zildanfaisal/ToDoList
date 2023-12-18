import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_todoapp_uas/view/login_page.dart';
import 'package:flutter_todoapp_uas/view/menu_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MenuPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'To Do List!',
              style: TextStyle(fontSize: 40, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
