import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../screen/sign_up_screen/verification/email_verification_screen/widget.dart';
import '../widgets/widget.dart';
class Success extends StatelessWidget {
  final String successIcon;
  final String text;
  final void Function() onTap;
  const Success({super.key, required this.successIcon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 35.h,left: 31.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backArrow(context),
            SizedBox(height: 144.h,),
            Container(
                margin: EdgeInsets.only(left: 84.w),
                child: Image.asset("assets/images/$successIcon")),
            SizedBox(height: 42.h,),
            Container(
                margin: EdgeInsets.only(left: 115.w),
                child: reusableText(text: text,size: 22.h,fontWeight: FontWeight.w600)),
            SizedBox(height: 71.h,),
            generalButton("Finish",isTextButton: false,size: 20.sp, func: () {
              onTap();

            })
          ],
        ),
      ),
    );
  }
}


