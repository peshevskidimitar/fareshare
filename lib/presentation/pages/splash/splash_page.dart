import 'dart:async';

import 'package:fareshare/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(72, 40, 61, 1.0),
      child: Column(
        children: [
          Image.asset(
            'assets/fare-share.jpg',
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Fare Share',
              style: GoogleFonts.sairaStencilOne(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
