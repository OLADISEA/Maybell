import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../common/entities/colors.dart';
import '../../../../common/widgets/widget.dart';
import '../reset_password_screen/reset_pass.dart';
import 'bloc/forgot_password_bloc.dart';
import 'bloc/forgot_password_event.dart';
import 'bloc/forgot_password_state.dart';


class ForgotPassword extends StatelessWidget {
  final String email;
  ForgotPassword({super.key, required this.email});

  final TextEditingController pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 45.h),
            child: BlocConsumer<ForgotPasswordBloc,ForgotPasswordState>(

              builder: (BuildContext context, state) {
                return      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 33.w),
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Image.asset("assets/images/left_arrow.png"),
                        ),
                      ),
                      SizedBox(height: 32.h,),
                      Padding(
                        padding: EdgeInsets.only(left: 33.w),
                        child: reusableText(
                            text: "Forgot Password",
                            fontWeight: FontWeight.w600,
                            size: 31.sp
                        ),
                      ),
                      SizedBox(height: 32.h,),
                      Padding(
                        padding: EdgeInsets.only(left:31.w),
                        child: reusableText(
                            text: "Enter the passcode you just received on",
                            fontWeight: FontWeight.w400,
                            size: 17.sp
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:31.w),
                        child: reusableText(
                            text: "your email address ${email.substring(-13)}......lexi@gmail.com",
                            fontWeight: FontWeight.w400,
                            size: 17.sp
                        ),
                      ),

                      SizedBox(height: 41.h,),
                      Form(
                        key: formKey,
                        child: Container(
                          padding: EdgeInsets.only(right: 20.w),
                          margin: EdgeInsets.only(left: 33.w,right: 51.w),
                          child: PinCodeTextField(
                            backgroundColor: AppColors.whiteColor,
                            appContext: context,
                            pastedTextStyle: const TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 4,
                            obscureText: true,
                            //obscuringCharacter:,
                            obscuringWidget: Image.asset("assets/images/hole.png",
                            ),
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 3) {
                                return "Please fill the entire text field";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 61,
                                fieldWidth: 61,
                                inactiveFillColor: AppColors.whiteColor,
                                activeColor: AppColors.mainColor,
                                selectedFillColor: AppColors.whiteColor,
                                selectedColor: AppColors.mainColor,
                                activeFillColor: AppColors.mainColor,
                                inactiveColor: AppColors.mainColor
                            ),
                            cursorColor: Colors.black,
                            animationDuration: const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            //errorAnimationController: errorController,
                            controller: pinController,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              pinController.text = value;
                              //debugPrint(value);
                              // setState(() {
                              //   currentText = value;
                              // });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");

                              return true;
                            },
                          ),
                        ),
                      ),
                      //SizedBox(height: 17.h,),
                      Container(
                        width: 363.w,
                        margin: EdgeInsets.only(left: 33.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 210.w,
                              child: reusableText(
                                  text: "Didn't receive any code?",
                                  fontWeight: FontWeight.w400,
                                  size: 15.sp,fontFamily: "Poppins"

                              ),
                            ),
                            Container(
                              width: 116.w,
                              margin: EdgeInsets.only(left:37.w),
                              child: reusableText(
                                  text: "Resend code",
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.mainColor,size: 16.sp,fontFamily: "Poppins"),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 51.h,),
                      generalButton("Verify",isTextButton: false,leftMargin:23.w,containerSize: 381.w,size: 24.sp, func:() {
                        context.read<ForgotPasswordBloc>().add(ForgotPassVerifyEvents(email: email, otp: pinController.text));


                      })

                    ]
                );
              },
              listener: (BuildContext context, state) {
                if(state is ForgotPassVerifySuccessState) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ResetPassword(email: email,)));
                }
                },

            ),
          )),
    );
  }
}
