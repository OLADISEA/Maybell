import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../common/widgets/widget.dart';
import '../onboarding_screen/welcome_page.dart';


class StartUp extends StatefulWidget {
  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 2 seconds
    Timer(Duration(seconds: 2), () {
      setState(() {
        // Update state to show the display after 2 seconds
        _showDisplay = true;
      });
    });
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const WelcomePage()));
    });
  }

  bool _showDisplay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 1500),
              width: _showDisplay ? 66.4.w:114.w,
              height: _showDisplay ? 134.08.h: 200.h, //
              child: Image.asset(
                'assets/logo/bell.png',
                //width: _showDisplay ? 100: 50,
                //height: 134.08,
              ),
            ),
            const SizedBox(height: 20),
            _showDisplay
                ? Text(
              'maybell',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w900,
                fontSize: 55.sp,
              ),
            )
                : Container(), // Empty container if display should not be shown yet
          ],
        )
      ),
    );
  }
}