import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/widgets/widget.dart';

class NotificationCard extends StatelessWidget {
  final String text;
  final String time;
  const NotificationCard({super.key,
    required this.text,
    required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.h,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(right: 26.w),
          height: 65.h,
          decoration: BoxDecoration(
              color: Color(0XFFD9D9D9),
              borderRadius: BorderRadius.circular(10.r)
          ),
          child: ListTile(
            contentPadding: EdgeInsets.only(top: 15,left: 10),
            title: reusableText(text: text,size: 13.sp,fontWeight: FontWeight.w600),
            leading: Image.asset("assets/logo/bell.png"),
            subtitle: reusableText(text: time,size: 10.sp)
            ),

        ),
      ),
    );
  }
}
