import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/entities/colors.dart';
import '../../../common/widgets/widget.dart';

Widget myDialog({required BuildContext context,required String title, required String content,required void Function() onTap}){
  return AlertDialog(
    title: reusableText(text: title,size: 19.sp,fontFamily: "Poppins"),
    content: Padding(
      padding: EdgeInsets.only(left: 65.w),
      child: reusableText(text: content,size: 19.sp,fontFamily: "Poppins"),
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 25.w),

        child: Row(
          children: [
            dialogButton(text: "Cancel",height:25.w,textButton: false, func: () {
              Navigator.of(context).pop();
            }),
            SizedBox(width: 35.w,),
            dialogButton(text: "Proceed",textButton: true, func: () {
              onTap();
            })

          ],
        ),
      ),
    ],
  );
}


Widget dialogButton({bool textButton = false,
required String text,
required void Function() func,
  double height = 35,
  double width = 80,

  double? size,
  double containerSize = 325,
  Color color = AppColors.mainColor,
  Color textColor = AppColors.whiteColor,
  }){
  return textButton?TextButton(
    onPressed: func, child: Center(
    child: Text(text,
      style: TextStyle(
          fontSize: size ?? 15.sp,
          fontWeight: FontWeight.bold,
          color: color
      ),),
  ),):Container(
    width: width,
    height: height,
    padding: EdgeInsets.only(bottom:7.h),
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.r)),
    child: InkWell(
      onTap: (){
        func();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Center(
          child: Text(text,
            style: TextStyle(
                fontSize: size ?? 15.sp,
                fontWeight: FontWeight.bold,
                color: textColor
            ),),
        ),
      ),
    ),
  );

}