import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/widgets/widget.dart';
import '../../../../sign_up_screen/verification/email_verification_screen/widget.dart';
import '../bloc/activity_bloc.dart';
import '../bloc/activity_state.dart';
import '../notification_screen/widgets.dart';


class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key,});

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
            reusableText(text: "Notifications",size: 20.sp),
           ],
        ),
        BlocBuilder<ActivityBloc,ActivityState>(

          builder: (BuildContext context, ActivityState state) {
            if(state is ActivityLoadInProgress){
              return Center(child: CircularProgressIndicator(),);
            }{
              if(state is ActivityLoadSuccess){
                //return Text(state.activities.length.toString());
                //return NotificationCard(text: text, time: time)
                return Expanded(
                    child: Stack(
                      children: [
                    ListView.builder(
                    itemCount: state.activities.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationCard(
                            text: state.activities[index].allowLogin
                                ?"You approved a mimi-chat login"
                                :"you decline a mimi-chat login",
                            time: state.activities[index].loginTime);
                      },
                    )
                      ]
                    )
                );
              }
            }return Container();
          },
        ),
          ]
          )
        )
      );
  }
}
