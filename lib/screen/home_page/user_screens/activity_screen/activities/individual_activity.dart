import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/widgets/widget.dart';
import '../../../../sign_up_screen/verification/email_verification_screen/widget.dart';
import '../../common/models/activity_data.dart';
import '../../common/widgets.dart';

class IndividualActivity extends StatelessWidget {
  final ActivityData activityData;
  const IndividualActivity({super.key, required this.activityData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 25.h,left: 34.w),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Row(
        children: [
          SizedBox(height:58.h,child: backArrow(context)),
          SizedBox(width: 71.w,),
          reusableText(text: "Activity",size: 20.sp),
        ],
        ),
              SizedBox(height: 31.h,),
              Container(
                  margin: EdgeInsets.only(left: 74.w),
                  child: activityIcons(logo: "instagram.png")),
              SizedBox(height: 82.h,),
              activityInfo(title: "Type", text: '${activityData.social} Login'),
              activityInfo(title: "Status", text: activityData.allowLogin?"Approved":"Declined"),
              activityInfo(title: "Time", text: activityData.loginTime),
              activityInfo(title: "Date", text: activityData.loginDate.toString()),
              activityInfo(title: "Device ID", text: activityData.trackedIpJsonData!.ip.toString()),



            ]
    )
      )
    );
  }
}
