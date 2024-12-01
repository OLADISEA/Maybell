import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maybell_apk/core/custom_notification.dart';
import '../../common/cards/social_media_cards.dart';
import '../../common/entities/colors.dart';
import '../../common/widgets/widget.dart';
import '../home_page/home_page.dart';
import '../sign_up_screen/sign_up_page.dart';
import 'bloc/log_in_bloc.dart';
import 'bloc/log_in_events.dart';
import 'bloc/log_in_states.dart';
import 'forgot_password/bloc/forgot_password_bloc.dart';
import 'forgot_password/bloc/forgot_password_event.dart';
import 'forgot_password/forgot_password.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  String errorState = "";
  String emailError = "";
  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();


  void connectToSocialMediaPlatform() {
    // Handle navigation to Google authentication/connect page
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<SignInBloc, SignInState>(
        
          builder: (BuildContext context, state) {
          if (state is SignInLoadingState) {
            print("Loading state");
            // Show circular progress indicator when loading
            // return Container(
            //   margin: EdgeInsets.only(top: 200.h),
            //   child: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // );
          }
            return Container(
              margin: EdgeInsets.only(top:201.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 30.h,
                      margin: EdgeInsets.only(left: 80.w,bottom: 62.h),
                      child: reusableText(
                          text: 'Welcome Back!',size: 32.sp)
                  ),
                  Container(
                    //color: Colors.red,
                    height: 249.h,
                    width: 326.w,
                    margin: EdgeInsets.only(left: 52.w,right: 52.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        reusableText(text: 'Email',size: 20.sp, fontWeight: FontWeight.w400,color:AppColors.mainColor),
                        textField(text: 'Enter your email ', icon: Icons.email,controller: emailController,
                            onChangeFunc: (value){
                              context.read<SignInBloc>().add(EmailAndPassEvents(
                                  email: emailController.text,
                                  ));
                              print(value);
                            }),
                        reusableText(text: emailError,size: 14.sp),
        
        
                        reusableText(text: "Password",color: AppColors.mainColor,size: 20.sp),
                        textField(text: 'Enter your password',
                            icon: Icons.lock_clock_rounded,
                            controller: passwordController,
                            onTap: (){
                              context.read<SignInBloc>().add(ToggleVisibilityEvents());
                            },
                            onChangeFunc: (value){
        
                              print(value);
                            },
                            hideVisibility: state.isVisible),
                        SizedBox(height: 10.h,),
        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: (){},
                                    icon: const Icon(Icons.check_box_outline_blank)
                                ),
                                reusableText(text: "Remember me",size: 14.sp, fontWeight: FontWeight.w300,color: AppColors.mainColor)
                              ],
                            ),
                            SizedBox(width: 61.w,),
                            generalButton("Forgot password?",size: 14.sp, func: (){
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=> ForgotPassword(email:emailController.text)));

                              context.read<ForgotPasswordBloc>().add(ForgotPasswordOTPEvents(email: emailController.text));
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=> ForgotPassword(email:emailController.text)));

                            })
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  state.isLoading?
                      Center(child: const CircularProgressIndicator()):
                  generalButton(
                      'Sign In',leftMargin:55.w,isTextButton: false,size: 24.sp,
                          func: () {
                    context.read<SignInBloc>().add(LoginButtonPressed(email: emailController.text,password: passwordController.text));
                  }),
                  SizedBox(height: 32.h),
                  Center(
                    child: reusableText(text: "OR", fontWeight: FontWeight.w600,size: 24,color: AppColors.darkGrey),
                  ),
                  SizedBox(height: 22.h),
        
                  SizedBox(
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 83.w),
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
                  SizedBox(height: 124.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      reusableText(text: 'Don\'t have an account?',size: 16.sp, fontWeight: FontWeight.w600),
                      generalButton('Sign Up', func: () {
                        //Routemaster.of(context).push('sign_up');
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>SignUp()));
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
            if(state is EmailState){
              emailError = state.emailError;
              showToast(emailError);
            }
            if(state is SignInSuccess){
              print("Success state");
              showToast("Success");
              Future.delayed(const Duration(milliseconds: 3000));
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>const HomePage()));
        
            }
            if(state is SignInErrorState){
              print("Sign in error state");
              errorState = "Unable to log in";
              showToast(errorState);
            }
            // if(state is ForgotPasswordSuccess){
            //   print("Listener: Passcode has been sent to your email");
            //   Navigator.push(context, MaterialPageRoute(builder: (builder)=> ForgotPassword(email:emailController.text)));
            // }
          },
        
        ),
      ),
    );
  }
}
