import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/widgets/widget.dart';
import '../../../../sign_up_screen/verification/email_verification_screen/widget.dart';
import '../../common/models/activity_data.dart';
import '../../common/widgets.dart';
import 'individual_activity.dart';

class ActivityHistory extends StatelessWidget {
  final List<ActivityData> activities;

  const ActivityHistory({Key? key, required this.activities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ActivityData> todayActivities = [];
    List<ActivityData> yesterdayActivities = [];
    List<ActivityData> othersActivities = [];

    // Filter activities for today, yesterday, and others
    for (var activity in activities) {
      print(activity.loginDate);
      print(DateTime.now());
      // Check if activity is for today
      if (isToday(activity.loginDate)) {
        todayActivities.add(activity);
      }
      // Check if activity is for yesterday
      else if (isYesterday(activity.loginDate)) {
        yesterdayActivities.add(activity);
      } else {
        // Assume activity is for others
        othersActivities.add(activity);
      }
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 25.h, left: 34.w,right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(height: 58.h, child: backArrow(context)),
                SizedBox(width: 71.w),
                reusableText(text: "Recent Activity", size: 20.sp),
              ],
            ),
            if (todayActivities.isNotEmpty)
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
                      child: reusableText(text: "Today", size: 20.sp),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: todayActivities.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => IndividualActivity(activityData: todayActivities[index]),
                                ),
                              );
                            },
                            child: activityList(text: todayActivities[index].allowLogin
                                ?"You approved a mimi-chat login"
                                :"you decline a mimi-chat login",
                
                                time: todayActivities[index].loginTime),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (yesterdayActivities.isNotEmpty)
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
                      child: reusableText(text: "Yesterday", size: 20.sp),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: yesterdayActivities.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => IndividualActivity(activityData: yesterdayActivities[index]),
                                ),
                              );
                            },
                            child: activityList(text: yesterdayActivities[index].allowLogin
                                ?"You approved a mimi-chat login"
                                    :"you decline a mimi-chat login",
                                time: yesterdayActivities[index].loginTime),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (othersActivities.isNotEmpty)
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
                      child: reusableText(text: "Others", size: 20.sp),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: othersActivities.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => IndividualActivity(activityData: othersActivities[index]),
                                ),
                              );
                            },
                            child: activityList(text: othersActivities[index].allowLogin
                                ?"You approved a mimi-chat login"
                                :"you decline a mimi-chat login",
                                 time: othersActivities[index].loginTime),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Function to check if a date is today
  bool isToday(DateTime? date) {
    if (date == null) {
      print("nothing");
      print(date);
      return false;
    }
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  // Function to check if a date is yesterday
  bool isYesterday(DateTime? date) {
    if (date == null) {
      return false;
    }
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    return date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day;
  }
}
