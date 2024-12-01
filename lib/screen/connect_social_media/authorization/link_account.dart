import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cards/success_card.dart';
import '../../../common/entities/colors.dart';
import '../../../common/widgets/widget.dart';
import '../../log_in_page/log_in_page.dart';
import '../../sign_up_screen/verification/email_verification_screen/widget.dart';
import 'lorem_ipsum_card.dart';

class LinkAccount extends StatelessWidget {
  final String username;
  const LinkAccount({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 31,right: 31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(top: 35),
                child: backArrow(context)),
            SizedBox(height: 300,),
            reusableText(text: "Are you sure you want to link",color: Color(0XFF2C2D2F),fontWeight: FontWeight.w500),
            reusableText(text: "this account?",color: Color(0XFF2C2D2F),fontWeight: FontWeight.w500),
            SizedBox(height: 53),
            // Social Media Account Selection Button
            Container(
              decoration: BoxDecoration(
                color: Color(0XFFD9D9D9), // Background color
                borderRadius: BorderRadius.circular(8), // Border radius
                border: Border.all(color: Color(0XFFD9D9D9)),
              ),
              child: ListTile(
              leading: Image.asset("assets/images/Twitter.png"), // Twitter logo
              title: reusableText(text: "@$username",color: Color(0XFF424141),size: 22), // Selected social media account
              //trailing: Icon(Icons.keyboard_arrow_down,color: AppColors.mainColor,)
              ),
            ), // Dropdown icon
            SizedBox(height: 15,),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.check_box_outline_blank,color: AppColors.mainColor,)),
                  SizedBox(width: 10,),
                  reusableText(text: "I agree to the terms and conditions",size: 14,color: AppColors.mainColor),
                ],
              ),
            ),
            SizedBox(height: 46,),
            generalButton("Confirm",size: 24,textColor:Color(0XFF898686),color:Color(0XFFE0E0E0),isTextButton: false,func:  () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TermsAndCondition()));
            })
          ],
        ),
      ),
    );
  }
}


class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 33.h,left: 34.w,right: 34.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backArrow(context),
            SizedBox(height: 11,),
            
            Center(child: reusableText(text: "Terms and Conditions",color: AppColors.blackColor,size: 28,fontWeight: FontWeight.w600)),
            SizedBox(height: 43,),
            reusableText(text: "LoremIpsumsitamet",size: 18,color: AppColors.mainColor),
            SizedBox(height: 16,),
            LoremIpsumWidget(wordCount: 100),
            SizedBox(height: 25,),
            reusableText(text: "LoremIpsumsitamet",size: 18,color: AppColors.mainColor),
            SizedBox(height: 16,),
            LoremIpsumWidget(wordCount: 50),
            SizedBox(height: 25,),
            reusableText(text: "LoremIpsumsitamet",size: 18,color: AppColors.mainColor),
            SizedBox(height: 16.h,),
            LoremIpsumWidget(wordCount: 40),
            SizedBox(height: 18.h,),
            generalButton("Next",isTextButton: false,size: 24.sp, func: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Success(
                successIcon: 'checked.png', text: 'Successful!',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignIn()));
                },)));
            })

          ],
        ),
      ),
    );
  }
}


