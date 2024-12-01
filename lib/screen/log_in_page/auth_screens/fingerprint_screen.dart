import 'package:flutter/material.dart';
import 'package:maybell_apk/screen/log_in_page/auth_screens/passcode_confirmation/passcode_auth.dart';
import 'package:maybell_apk/screen/log_in_page/auth_screens/verify_user.dart';

import '../../../common/cards/fingerprint_card.dart';
import '../../../common/cards/success_card.dart';
import '../../home_page/home_page.dart';
import '../../sign_up_screen/verification/email_verification_screen/widget.dart';



class FingerPrintScreen extends StatelessWidget {
  final String loginStatus;
  FingerPrintScreen({required this.loginStatus,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 29,),
            Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: backArrow(context),
            ),
            SizedBox(height: 120,),
            FingerPrintCard(
              title: "Click to Authorize with Fingerprint",
              subTitle: "Authorize with Passcode",
              title2: "Please Authenticate to add approve Login",
              skip: true,
              moveToPasscode: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthorizationPass()));
              },
              onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Success(successIcon: "checked.png", text: loginStatus, onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomePage()));
                }), // Replace AnotherPage with your desired page
              ));
            },
            )

          ],
        ),

      ),
    );
  }
}
