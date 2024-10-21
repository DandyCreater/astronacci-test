import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../core/constanta/constanta_string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToLogin();
  }

  moveToLogin() async {
    await Future.delayed(const Duration(seconds: 2)).then(
        (value) => Navigator.pushNamed(context, RouteConstanta.loginScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/images/dashboard.png')),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                "Mobile Developer Test",
                style: GoogleFonts.montserrat(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ));
  }
}
