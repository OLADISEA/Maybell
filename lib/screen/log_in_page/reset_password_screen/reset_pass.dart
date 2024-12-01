import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/entities/colors.dart';
import '../../../common/widgets/widget.dart';
import 'bloc/reset_bloc.dart';
import 'bloc/reset_events.dart';
import 'bloc/reset_states.dart';


class ResetPassword extends StatelessWidget {
  final String email;
  ResetPassword({super.key, required this.email});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ResetPassBloc,ResetPassStates>(
        builder: (context, ResetPassStates state){
          return Container(
            width: 328.w,
            margin: EdgeInsets.only(left: 51.w,right: 52.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 219.h,left: 80,bottom: 82),
                  child: reusableText(
                  text: 'Reset Password',size: 32, color: AppColors.blackColor,fontWeight: FontWeight.w600)
                ),
                reusableText(text: 'New Password',size: 20, fontWeight: FontWeight.w400,color:AppColors.mainColor),
                SizedBox(height: 34,),
                textField(text: 'Enter your password', icon: Icons.lock_clock_rounded,controller: passwordController,
                onChangeFunc: (value){

                print(value);
                }),
                SizedBox(height: 14,),

                reusableText(text: "Confirm Password",color: AppColors.mainColor,size: 20),
                SizedBox(height: 34,),

                textField(
                    text: 'Enter your password',
                    icon: Icons.lock_clock_rounded,
                    controller: confirmPassController,
                    onTap: (){
                      context.read<ResetPassBloc>().add(ToggleEvents());
                    },
                    onChangeFunc: (value){

                      print(value);
                },
                  hideVisibility: state.isVisible),


              SizedBox(height: 32),
              Center(
              child: generalButton(
                  'Submit',
                  isTextButton: false,
                  size: 24.sp,
                  func: () {
                    context.read<ResetPassBloc>().add(TriggerResetPassword(
                        email: email,
                        password: passwordController.text,
                        confirmPass: confirmPassController.text
                    ));
                  }),
              ),
              // SizedBox(height: 20.h,),
              //reusableText(text: errorState)

              ],
              ),
          );
        }, listener: (BuildContext context, ResetPassStates state) {  },

      )
    );
  }
}
