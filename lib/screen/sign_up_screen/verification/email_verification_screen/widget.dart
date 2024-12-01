import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pin_keyboard/pin_keyboard.dart';

import '../../../../common/entities/colors.dart';
import '../../../../common/widgets/widget.dart';

Widget myPinCode({
  String errorText = "Please fill the entire text field",
  required BuildContext context,
  required GlobalKey formKey,
  required String title,
  required TextEditingController pinController,
  void Function()? onComplete,

}){
  return  Padding(
    padding: EdgeInsets.only(top: 29.h),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         Padding(
           padding: EdgeInsets.only(left: 28.w),
           child: backArrow(context),
         ),
          SizedBox(height: 32.h,),
          Padding(
            padding: EdgeInsets.only(left: 114.w),
            child: reusableText(
                text: title,
                fontWeight: FontWeight.w600,
                size: 26.sp
            ),
          ),
          SizedBox(height: 57.h,),
          Form(
            key: formKey,
            child: Container(
             // padding: EdgeInsets.only(right: 20.w),
              margin: EdgeInsets.only(left: 60.w,right: 66.w),
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
                    return errorText;
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(0),
                    fieldOuterPadding: const EdgeInsets.all(0),
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
                  if(v.length >3){
                    onComplete!();
                    debugPrint("true");

                  }

                  debugPrint("Completed");
                },
                onChanged: (value) {

                  debugPrint(value);



                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");

                  return true;
                },
              ),
            ),
          ),

          SizedBox(height: 101.h,),

          Container(
            margin: EdgeInsets.only(left: 64.w,right: 64.w),
            child: PinKeyboard(
                maxWidth: 302.w,
                fontSize: 36,
                space: 90,
                iconBackspaceColor: AppColors.mainColor,
                iconBackspace: Image.asset("assets/images/backspace.png",height: 50,),
                enableBiometric: false,
                length: 4,
                onChange: (pin){
                  pinController.text = pin;
                }),
          )

        ]
    ),
  );
}


Widget backArrow(BuildContext context){
  return  InkWell(
    onTap: (){
      Navigator.pop(context);
    },
    child: Image.asset("assets/images/left_arrow.png",),
  );
}