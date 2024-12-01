import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../common/entities/colors.dart';
import '../../../../common/widgets/widget.dart';
import '../../../sign_up_screen/verification/email_verification_screen/widget.dart';
import '../../widgets/widget.dart';
import '../fingerprint_screen.dart';
import 'bloc/allow_login_bloc.dart';
import 'bloc/allow_login_event.dart';
import 'bloc/allow_login_state.dart';


class Authorization extends StatelessWidget {
  final String socialMediaName;
  final String username;
  final String loginInfoId;
  final String phoneModel;
  const Authorization({
    super.key,
    required this.socialMediaName,
    required this.username,
    required this.loginInfoId,
    required this.phoneModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 52.h, left: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                    height: 58.h,
                    width: 40.w,
                    child: backArrow(context)),
                SizedBox(width: 67.w),
                SizedBox(
                    height:28.h,
                    width: 166.w,
                    child: reusableText(text: "Authorization", size: 26.sp,fontFamily: "Poppins",fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 199.h),
            Container(
              //color: Colors.red,
              margin: EdgeInsets.only(left: 74.w),
              child: activityIcons(logo: "instagram.png"),
            ),
            SizedBox(height: 98.h),
            Container(
              margin: EdgeInsets.only(left: 26.w),
                child: reusableText(text: "A login Attempt was made to your",size: 21.sp,fontFamily: "Poppins",color: Color(0XFF424141))),
            Container(
              margin: EdgeInsets.only(left: 26.w),
              child: Row(
                children: [
                  reusableText(text: "$socialMediaName Account",size: 21.sp,fontFamily: "Poppins",color: Color(0XFF424141)),
                  reusableText(text: " @$username",size: 21.sp,fontFamily: "Poppins", color: AppColors.mainColor),
                ],
              ),
            ),
            SizedBox(height: 23.h,),
            Container(
              margin: EdgeInsets.only(left: 26.w),
              child: Row(
                children: [
                  reusableText(text: "Device name: ",size: 21.sp,fontFamily: "Poppins",color: Color(0XFF424141)),
                  reusableText(text: " $phoneModel",size: 21.sp,fontFamily: "Poppins", color: AppColors.mainColor),
                ],
              ),
            ),
            SizedBox(height: 53.h,),
            Padding(
              padding: EdgeInsets.only(left: 145.w),
              child: reusableText(text: "was this you?",size: 17.sp,fontFamily: "Poppins",fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 27.h),

            BlocConsumer<AllowLoginBloc,AllowLoginState>(
              builder: (BuildContext context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 57.w),
                      child: dialogButton(
                        text: "Yes, it's me",
                        textButton: false,
                        size: 14.sp,
                        width: 120.w,
                        height: 30.h,
                        func: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return myDialog(
                                context: context,
                                title: "Are you sure you want to Authorize",
                                content: 'this login?',
                                onTap: () {
                                  context.read<AllowLoginBloc>().add(AllowLoginRequested(
                                      allowLogin: true,
                                      loginInfoId:loginInfoId
                                  ));

                                  //),
                                  //);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 36.w),
                    dialogButton(
                      text: "No, it's not",
                      textButton: false,
                      size: 14.sp,
                      width: 120.w,
                      height: 30.h,
                      func: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return myDialog(
                              context: context,
                              title: "Are you sure you want to Decline",
                              content: 'this login?',
                              onTap: () {
                                context.read<AllowLoginBloc>().add(AllowLoginRequested(
                                    allowLogin: false,
                                    loginInfoId: loginInfoId));

                                Navigator.pop(context); // Close the dialog
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              }, listener: (BuildContext context, state) {
                if(state is AllowLoginSuccess){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => FingerPrintScreen(loginStatus: state.loginStatus,)));
                }
            },

            ),
          ],
        ),
      ),
    );
  }
}
