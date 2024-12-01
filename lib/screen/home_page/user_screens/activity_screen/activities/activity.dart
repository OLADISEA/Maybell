import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common/entities/colors.dart';
import '../../../../../common/widgets/widget.dart';
import '../../../../../data/repository/user_tokens.dart';
import '../../../../log_in_page/log_in_page.dart';
import '../../common/cards/activity_card.dart';
import '../../common/widgets.dart';
import '../bloc/activity_bloc.dart';
import '../bloc/activity_event.dart';
import '../bloc/activity_state.dart';
import 'activity_history.dart';
import 'individual_activity.dart';
import 'notification_page.dart';



class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  String username = '';
  int notificationsNum = 0;
  @override
  void initState() {
    _loadUserName();
    context.read<ActivityBloc>().add(FetchActivities());
    super.initState();
  }


  Future<void> _loadUserName() async {
    final fetchedUsername = await AccessTokenProvider.getUserName();
    if (fetchedUsername != null) {
      setState(() {
        username = fetchedUsername;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 32.h,left: 26.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 InkWell(
                      onTap: (){
                        // PersistentNavBarNavigator.pushNewScreen(
                        //     context,
                        //     screen: const NotificationPage(),
                        //     withNavBar: false,
                        //     pageTransitionAnimation: PageTransitionAnimation.cupertino
                        // );
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NotificationPage()));

                      },
                      child: Stack(
                        children: [
                          Image.asset("assets/images/Doorbell.png"),
                          BlocBuilder<ActivityBloc, ActivityState>(
                            builder: (context,state) {
                              return notificationsNum>1?Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Text(
                                    notificationsNum>1?notificationsNum.toString():'',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ):Container();
                            }
                          ),
                        ],
                      ),
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: reusableText(text: username,size: 18.sp,fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.w,left: 10.w,top: 10.h),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/user_pic.png"),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 20.h,),
            SizedBox(height:40.h,child: reusableText(text: "Good evening $username",size: 14.sp,fontWeight: FontWeight.w500)),
            // SizedBox(height: 8.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 131.h,
                  width: 157.w,
                  decoration: BoxDecoration(
                      color: const Color(0XFFE0E0E0),
                    borderRadius: BorderRadius.circular(10.r)
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: reusableText(text: "Activity Rate",size: 14.sp)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Image.asset("assets/images/arrow.png"),
                          SizedBox(width: 12.h,),
                          reusableText(text: "51%",color: AppColors.mainColor,size: 36.sp,fontWeight: FontWeight.w700)
                        ],
                      )

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w),
                  decoration: BoxDecoration(
                      color: const Color(0XFFE0E0E0),
                      borderRadius: BorderRadius.circular(10.r)
                    ),
                  height: 131.h,
                  width: 207.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: reusableText(text: "Top Three Account Activity",size: 14.sp,fontWeight: FontWeight.w700)),
                      SizedBox(height: 14.h,),
                      Container(
                        padding: EdgeInsets.only(left: 10.w),
                        //color: Colors.blue,
                        width: 196.w,
                        height: 89.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20.h),
                              //color: Colors.red,
                                height: 80.h,
                                width: 85.w,
                                child: const ActivityChart()
                            ),
                            //SizedBox(width: 5.w,),
                            Container(
                              height: 80.h,
                              width: 100.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 18.84.h,
                                      width: 82.45.w,
                                      child: activityTile(percentage: "55%", label: "Completed")),
                                  SizedBox(height: 8,),
                                  Container(
                                      height: 18.84.h,
                                      width: 82.45.w,
                                      child: activityTile(percentage: "30%", label: "In-Progress")),
                                  SizedBox(height: 8,),
                                  Container(
                                      height: 18.84.h,
                                      width: 82.45.w,
                                      child: activityTile(percentage: "15%", label: "Not Started")),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
            SizedBox(height: 10.h,),
            BlocConsumer<ActivityBloc, ActivityState>(
                builder: (context, state) {

                  if (state is ActivityLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ActivityLoadSuccess) {
                    notificationsNum = state.activities.length;
                    return Container(
                      height: 600.h,
                      width: 375.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 26.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 50.h,
                                    child: Center(child: reusableText(
                                        text: "Recent Activity",
                                        size: 20.sp,
                                        fontWeight: FontWeight.w600))),
                                generalButton("See all", func: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NotificationPage()));

                                },size: 16.sp)

                              ],
                            ),
                          ),
                          //SizedBox(height: 9,),
                          Expanded(
                            child: Stack(
                              children: [
                                ListView.builder(
                                  itemCount: state.activities.length>5? 5:state.activities.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                            IndividualActivity(
                                              activityData: state.activities[state.activities.length-1-index],)));
                                      },
                                      child: activityList(
                                          text: state.activities[state.activities.length-1-index].allowLogin
                                              ?"You approved a mimi-chat login"
                                              :"you decline a mimi-chat login",
                                          time: state.activities[index].loginTime),
                                    );
                                  },
                                ),
                                Positioned(
                                    right: 38.w,
                                    bottom: 0,
                                    child: FloatingActionButton(
                                      heroTag: null,
                                      backgroundColor: AppColors.mainColor,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (
                                                context) => ActivityHistory(activities: state.activities,)));
                                      },
                                      child: const Icon(
                                        Icons.add, color: Colors.white,),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (state is ActivityLoadFailure) {
                    // Displaying error message
                    return const Center(child: Text('Error loading activities'));
                  } else {
                    // Other states will be handled here
                    return Container();
                  }
                }, listener: (BuildContext context, ActivityState state) async{
                      if(state is AccessTokenExpired) {
                        final prefs = await SharedPreferences.getInstance();
                        // Perform sign out logic here
                        await prefs.setBool('isLoggedOut',true);
                        await prefs.setBool("isLoggedIn", false);
                        // Show a toast message
                        Fluttertoast.showToast(
                          msg: "Login Expired. Please sign in again.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );

                        // Delay navigation to give time for the toast message to be displayed
                        Future.delayed(Duration(seconds: 3), () {
                          // Navigate to SignIn screen
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignIn()));
                        });
                      }
            },)
              ],
            ),
      )
    );
  }
}
