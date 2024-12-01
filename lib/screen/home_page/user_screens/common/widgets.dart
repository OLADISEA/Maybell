import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/entities/colors.dart';
import '../../../../common/widgets/widget.dart';

Widget activityTile({required String percentage,required String label}){
  return ListTile(
    //contentPadding: EdgeInsets.only(right: 2),
    title: Container(
      height: 20.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.blackShade,
        )
      ),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          reusableText(text: label,size: 5.sp,fontWeight: FontWeight.w200,color: Colors.black),
          SizedBox(width: 4.w,),
          reusableText(text: percentage,size: 5.sp)

        ],
      ),
    ),
    //leading: Center(child: Text(label)),
  );
}

Widget activityList({required String text, required String time}){
  return  Container(
    width: 375.w,
    margin: EdgeInsets.only(bottom: 9.h,),
    height: 81.h,
    decoration: BoxDecoration(
      color: Color(0XFFD9D9D9),
      borderRadius: BorderRadius.circular(10.r)
    ),
    child: ListTile(
      title: Text(text),
      leading: const CircleAvatar(
        backgroundImage: AssetImage("assets/images/user_pic.png"),
      ),
      subtitle: Text(time),
  ),
  );
}

Widget activityInfo({required String title,required String text}){
  return Container(
    padding: EdgeInsets.only(right: 25.w),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w,right: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              reusableText(text: title,size: 20.sp,fontWeight: FontWeight.w300),
              reusableText(text: text,size: 20.sp,fontWeight: FontWeight.w500,fontFamily: "Poppins")
            ],
          ),
        ),
        SizedBox(
            width: 367.w,
            child: const Divider(
              color: AppColors.mainColor,
            ))
      ],
    ),
  );
}