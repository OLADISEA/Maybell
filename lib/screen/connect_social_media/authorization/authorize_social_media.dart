import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/widgets/widget.dart';
import '../../sign_up_screen/verification/email_verification_screen/widget.dart';
import 'bloc/authorization_bloc.dart';
import 'bloc/authorization_events.dart';
import 'bloc/authorization_states.dart';
import 'link_account.dart';

class AuthorizeAccount extends StatelessWidget {
  final String selectedAccount;
  AuthorizeAccount({super.key, required this.selectedAccount});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 35.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.w),
                    height: 39.h,
                    width: 28.w,
                    child: backArrow(context)),
                Container(
                    margin: EdgeInsets.only(left: 209.w),
                    child: reusableText(text: "Login to Instagram",size: 16.sp))
              ],
            ),
            SizedBox(height: 7.h,),
            Divider(
              color: Color(0XFF898686),
            ),
            Container(
              margin: EdgeInsets.only(top: 28.h,left: 26.w,right: 34.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/social_media/instagram2.png"),
                  SizedBox(height: 35.h,),
                  Container(
                    margin: EdgeInsets.only(right: 63.w),
                    height: 60.h,
                    width: 341.w,
                    //color: Colors.red,
                    child: reusableText(
                        text: "Authorize Maybell to use to connect to your $selectedAccount account",
                        size: 24.sp
                    ),
                  ),
                  SizedBox(height: 63.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/logo/bell.png',
                        width: 45.w,
                        height: 64.h,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'maybell',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          fontSize: 36.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60.h,),
                  authorizeAccountTextField(text: "Username / Email",controller: emailController),
                  SizedBox(height: 16.h,),
                  authorizeAccountTextField(text: "Password",obscureText: true,controller: passwordController),
                  SizedBox(height: 16.h,),
                  Container(
                    //color: Colors.blue,
                    height: 30.h,
                    width: 272.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.check_box_outline_blank)
                        ),

                        reusableText(text: "I agree to the terms and conditions",size: 14.sp),

                      ],
                    ),
                  ),
                  SizedBox(height: 22.h,),
                  BlocListener<AuthorizationBloc,AuthorizationState>(
                    listener: (BuildContext context, state) {
                      if(state is AuthorizationSuccess){
                        username = state.username;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LinkAccount(username: username)));
                      }
                    },
                    child: Container(
                      //color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          InkWell(
                            onTap: (){
                              context.read<AuthorizationBloc>().add(VerifyAccountEvents(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  socialMediaName: selectedAccount
                              ));
                            },
                            child: Container(
                              height: 40.h,
                              width: 98.w,
                              color: Color(0XFF9747FF),
                              child: reusableText(text: "Sign In",size: 16.sp),

                            ),
                          ),
                          SizedBox(width: 19,),
                          Container(
                            height: 40.h,
                            width: 98.w,
                            decoration: BoxDecoration(
                              color: Color(0XFFFFFFFF),
                              border: Border.all(
                                color: Color(0XFF9747FF)
                              )
                            ),
                            child: reusableText(text: "Cancel",size: 16.sp,color: Color(0XFF9747FF)),

                          )
                        ],
                      ),
                    ),
                  )

              ]
            ))


          ],
        ),
      ),
    );
  }
}
