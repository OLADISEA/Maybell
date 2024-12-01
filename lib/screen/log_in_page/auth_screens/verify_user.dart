import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cards/fingerprint_card.dart';
import '../../../common/widgets/widget.dart';






class VerifyUser extends StatefulWidget {
  const VerifyUser({Key? key}) : super(key: key);

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 107.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appLogo(showDisplay: true),
            SizedBox(height: 83.h,),
            FingerPrintCard(
                title: "Click to Login with Fingerprint",
                subTitle: "Unlock with Passcode",
                title2: "Please Authenticate to use Maybell",
                skip: true, onTap: () {
                  //Navigator.of(context).push(MaterialPageRoute(
                  //builder: (context) => Authorization(), // Replace AnotherPage with your desired page
              //)
              //);
            },
            )

          ],
        ),
      ),

    );
  }
}
