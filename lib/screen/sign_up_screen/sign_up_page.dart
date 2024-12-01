import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maybell_apk/core/custom_notification.dart';
import 'package:maybell_apk/screen/sign_up_screen/verification/email_verification_screen/verify_email.dart';

import '../../common/cards/social_media_cards.dart';
import '../../common/entities/colors.dart';
import '../../common/widgets/widget.dart';
import '../log_in_page/log_in_page.dart';
import 'bloc/signup_bloc.dart';
import 'bloc/signup_events.dart';
import 'bloc/signup_states.dart';



class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  String emailError = "";
  String passwordError = "";
  String errorState = "";
  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  TextEditingController nameController =  TextEditingController();
  TextEditingController confirmPassController =  TextEditingController();
  //bool signupButton = true;




  void connectToSocialMediaPlatform() {
    // Handle navigation to Google authentication/connect page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<SignUpBloc, SignUpState>(
        
          builder: (BuildContext context, state) {
            print('The state in the build method is ${state.isButtonEnabled}');
            if (state is LoadingState) {
              print("Loading state......");
              // Show circular progress indicator when loading
              // return const Center(
              //   child: CircularProgressIndicator(),
              // );
            }
            return Container(
              margin: EdgeInsets.only(top: 106.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 28.h,
                      width: 276.w,
                      margin: EdgeInsets.only(left: 57.h),
                      child: reusableText(
                          text: 'Create an account',size: 32.sp, fontWeight: FontWeight.w600)
                  ),
                  //SizedBox(height: 49.h,),
                  Container(
                    margin: EdgeInsets.only(top: 41.h,left: 52.w,right: 52.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableText(text: 'Name',size: 20.sp, fontWeight: FontWeight.w400,color:AppColors.mainColor),
                        SizedBox(height: 6.h,),
        
                        textField(text: 'Enter your Name ', icon: Icons.email,controller: nameController,
                            onChangeFunc: (value){
        
                              print(value);
                            }),
                        SizedBox(height: 15.h,),
                        reusableText(text: 'Email',size: 20.sp, fontWeight: FontWeight.w400,color:AppColors.mainColor),
                        SizedBox(height: 6.h,),
                        textField(text: 'Enter your Email ', icon: Icons.email,controller: emailController,
                            onChangeFunc: (value){
        
                              print(value);
                            }),
                        emailError.isNotEmpty?reusableText(text: emailError,color: Colors.red):Container(),
                        SizedBox(height: 15.h,),


                        reusableText(text: "Password",color: AppColors.mainColor,size: 20),
                        SizedBox(height: 6.h,),


                        textField(text: 'Enter your password',
                            icon: Icons.lock_clock_rounded,
                            controller: passwordController,
                            onTap: (){
                              context.read<SignUpBloc>().add(ChangeVisibilityEvents());
                            },
                            onChangeFunc: (value){
        
                              print(value);
                            },
                            hideVisibility: state.isVisible),
                        passwordError.isNotEmpty?reusableText(text: passwordError,color: Colors.red,size: 13.sp):Container(),
                        SizedBox(height: 15.h,),
                        reusableText(text: "Confirm Password",color: AppColors.mainColor,size: 20),
                        SizedBox(height: 6.h,),


                        textField(text: 'Enter your password',
                            icon: Icons.lock_clock_rounded,
                            controller: confirmPassController,
                            onTap: (){
                              context.read<SignUpBloc>().add(ChangeVisibilityEvents());
                            },
                            onChangeFunc: (value){
        
                              print(value);
                            },
                            hideVisibility: state.isVisible),
        
                      ],
                    ),
                  ),
                  SizedBox(height: 34.h),
                  state.isLoading?
                      const Center(child: CircularProgressIndicator(),)
                      :generalButton(
                      'Sign Up',size: 24.sp,leftMargin: 52.w,isTextButton: false,isButtonEnabled: state.isButtonEnabled,
                          func: () {
                        print('the state now is ${state.isButtonEnabled}');

                        context.read<SignUpBloc>().add(SignUpCompletedEvents(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text));
                      }),
                  SizedBox(height: 45.h),
                  Center(
                    child: reusableText(text: "OR", fontWeight: FontWeight.w600,size: 24,color: AppColors.darkGrey),
                  ),
                  SizedBox(height: 22.h),
        
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 77.w),
                          child: SocialMediaRow(
                              image: 'assets/images/social_media/facebook.png',
                              onTap: connectToSocialMediaPlatform
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 60.w),
                          child: SocialMediaRow(
                              image: 'assets/images/social_media/google.png',
                              onTap: connectToSocialMediaPlatform
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 60.w),
                          child: SocialMediaRow(
                              image: 'assets/images/social_media/apple.png',
                              onTap: connectToSocialMediaPlatform
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 34.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      reusableText(text: 'Already have an account?',size: 16.sp, fontWeight: FontWeight.w600),
                      generalButton('Log in', func: () {
                        //Routemaster.of(context).push('sign_up');
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>SignIn()));
                        print("Log in successful");
                      },size: 16.sp),
        
                    ],
                  ),
        
                  // SizedBox(height: 20.h,),
                  //reusableText(text: errorState)
        
                ],
              ),
            );
          },
          listener: (BuildContext context, state) {
            //print('The state that is getting me tired is ${state.isButtonEnabled}');
            if(state is ErrorState){
              showToast(state.errorMessage);
              print("This is the error state");
              //print('The state that is getting me tired is ${state.isButtonEnabled}');
            }
              if(state is EmailAndPassStates){
               // print('The state that is getting me tired is ${state.isButtonEnabled}');
                showToast('Email or Password is not valid');
                emailError = state.emailError;
                passwordError = state.passwordError;
              }
              if(state is SignUpSuccess){
                //print('The state that is getting me tired is ${state.isButtonEnabled}');
                showToast("Account Created");
                Future.delayed(const Duration(milliseconds: 3000));
                print("Listener has confirmed that sign up is successful");
                //print("The sign up success email ${state.userEmail}");
                Navigator.push(context, MaterialPageRoute(builder: (builder)=> VerifyEmail(email: emailController.text,)));

              }
              if(state is EmailVerifyState){
                print("email already exists");
                showToast(" ${state.userEmail} needs verification");
                //print('The state that is getting me tired is ${state.isButtonEnabled}');

                print("Listener has confirmed that user has an account and will navigate soon");
                print("The sign up success email ${state.userEmail}");
                Navigator.push(context, MaterialPageRoute(builder: (builder)=> VerifyEmail(email: state.userEmail,)));
              }
            }
        
        ),
      ),
    );
  }
}
