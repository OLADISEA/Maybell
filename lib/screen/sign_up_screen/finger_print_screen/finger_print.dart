import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/cards/fingerprint_card.dart';
import '../../log_in_page/auth_screens/passcode_confirmation/passcode_auth.dart';
import '../../onboarding_screen/welcome_page.dart';
import '../verification/email_verification_screen/widget.dart';



class FingerPrintVerify extends StatefulWidget {
  final bool skip;
  final String title2;
  FingerPrintVerify({Key? key, required this.skip, required this.title2}) : super(key: key);

  @override
  State<FingerPrintVerify> createState() => _FingerPrintVerifyState();
}

class _FingerPrintVerifyState extends State<FingerPrintVerify> {



  @override
  Widget build(BuildContext context) {
    print(widget.skip);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 29.h,),
            Padding(
              padding: EdgeInsets.only(left: 28.w),
              child: backArrow(context),
            ),
            FingerPrintCard(
                title: "Click to Add Fingerprint",
                subTitle: "Authorize with Passcode",
                title2: widget.title2.isNotEmpty?widget.title2:"Please Authenticate to add fingerprint",
                skip: widget.skip, onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const GettingStarted(), // Replace AnotherPage with your desired page
              ));
            },
              moveToPasscode: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AuthorizationPass()));
              }
                  ),

                ],
              ),

        ),
      );
  }
}
