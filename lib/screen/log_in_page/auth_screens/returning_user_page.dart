import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maybell_apk/screen/log_in_page/auth_screens/verify_user.dart';
import '../../../common/cards/success_card.dart';
import '../../../common/entities/colors.dart';
import '../../../common/widgets/widget.dart';
import '../../home_page/home_page.dart';
import '../forgot_password/forgot_password.dart';

class ReturningUserPage extends StatelessWidget {
  ReturningUserPage({super.key});

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 117.h,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 126.w),
              width: 178.w,
              height: 64.h,
              child: appLogo(showDisplay: true),
            ),
            SizedBox(height: 26.h,),

            Padding(
              padding: EdgeInsets.only(left: 115.h),
              child: reusableText(text: "Welcome Back!",size: 25.w,fontFamily: "Poppins",fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 45,),
            Container(
              height: 91.h,
                //color: Colors.red,
                margin: EdgeInsets.only(left: 38.h,right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:30.h,child: reusableText(text: 'Password',size: 22.sp, fontWeight: FontWeight.w400,color:AppColors.blackColor)),
                    SizedBox(height: 4.h,),
                    passwordTextField(text: 'Enter Password',size: 20.sp, controller: passwordController,
                        onChangeFunc: (value){

                          print(value);
                        }),

                  ],
                )
            ),
            //SizedBox(height: 10.h,),
            Container(
              margin: EdgeInsets.only(left: 268.w),
              //padding: EdgeInsets.only(bottom: 70),
              child: generalButton("Forgot password?",size: 14,color: Color(0XFF424141),func: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=> ForgotPassword(email: "",)));
              }),
            ),
            SizedBox(height: 45.h,),

            Center(child: generalButton("Log in",color: AppColors.mainColor,isTextButton: false,size: 20.sp, func: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  Success(successIcon: "checked.png", text: "Login Approved!", onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomePage()));

                  })));

            })),
            SizedBox(height: 45.h,),

            Container(
              margin: EdgeInsets.only(left: 128.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/fingerprint.png",width: 30,color: AppColors.blackShade,),
                  SizedBox(width: 10.w,),
                  InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> VerifyUser()));
                      },
                      child: reusableText(text: "Unlock with Fingerprint",color: AppColors.mainColor,size: 14.sp))
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
