import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/widgets/widget.dart';

class AccountCard extends StatelessWidget {
  final String name;
  final String image;
  final String socialMediaLogo;
  final String socialMediaName;
  const AccountCard({Key? key, required this.name, required this.image, required this.socialMediaLogo, required this.socialMediaName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 10,right: 30),
      color: Color(0XFFD9D9D9),
      child: ListTile(
        title: Row(
          children: [
            Image.asset("assets/images/$socialMediaLogo"),
            SizedBox(width: 5.w,),
            reusableText(text: socialMediaName,size: 20.sp)
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: reusableText(text: name,size: 17.sp),
        ),
        leading: CircleAvatar(
          radius: 20.r,
          backgroundImage: AssetImage("assets/images/$image"),
        ),
        //trailing: Image.asset("assets/images/$socialMediaLogo"),
      ),
    );
  }
}
