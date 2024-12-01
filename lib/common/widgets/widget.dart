import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../screen/log_in_page/auth_screens/returning_user_page.dart';
import '../../screen/sign_up_screen/sign_up_page.dart';
import '../entities/colors.dart';

Widget appLogo({bool showDisplay = false,double? width}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'assets/logo/bell.png',
        width:width?? 45.w,
        height: 64.h,
      ),
      const SizedBox(height: 20),
      showDisplay
          ? Text(
        'maybell',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w800,
          fontSize: 36.sp,
        ),
      )
          : Container(), // Empty container if display should not be shown yet
    ],
  );
}

Widget reusableText({
  required String text,
  FontWeight fontWeight = FontWeight.w400,
  String fontFamily = 'Montserrat',
  double size = 32,
  Color color = AppColors.blackColor}){
  return Text(text,
    style: TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontSize: size,
      //height: 20.h,
      //letterSpacing: 1.5,
      //wordSpacing: 1.2,
      //overflow: TextOverflow.ellipsis,
      fontWeight: fontWeight,

    ),);
}

Widget passwordTextField({required String text,Function()? onTap,double size =15,TextEditingController? controller,
              Function(String)? onChangeFunc}){
  return Center(
    child: Container(
      width: 364.w,
      height: 57.h,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.r)
      ),

      //margin: EdgeInsets.only(bottom: 10.h),
      child: TextField(
        controller: controller,
        obscureText: true,
        onChanged: onChangeFunc,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.mainColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              //borderSide: BorderSide(color: Colors.grey)
            ),
            hintStyle: TextStyle(
                color: AppColors.greyColor,
                fontSize: size
            ),
            hintText: text,



        ),
      ),
    ),
  );
}


Widget textField({
  required String text,
  required IconData icon,
  IconData? icon2,
  double size =15,
  bool hideVisibility = false,
  void Function()? onTap,
  String? correctPassword,
  TextEditingController? controller,
  Function(String)? onChangeFunc
}){
  return Container(
    height: 57.h,
    width: 326.w,
    color: Colors.grey.shade200,
    child: TextField(
      controller: controller,
      obscureText: hideVisibility? hideVisibility:false,
      onChanged: onChangeFunc,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 23.h),
          border: InputBorder.none,
          // // enabledBorder: OutlineInputBorder(
          // //   borderRadius: BorderRadius.circular(10.r),
          // //   borderSide: BorderSide(color: Colors.grey.shade200),
          // // ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
                color: AppColors.mainColor,

            ),
          ),
          // disabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.r),
          //   borderSide: BorderSide(color: Colors.grey)
          //   ),
          hintStyle: TextStyle(
              color: AppColors.greyColor,
              fontSize: size
          ),
          hintText: text,
          prefixIcon: Icon(icon),
          prefixIconColor: Colors.grey.shade500,
          suffixIcon:text == "Enter your password" || text == "Confirm Password"?IconButton(
            onPressed: onTap,
            icon: hideVisibility?
            Icon(Icons.visibility)
                :const Icon(Icons.visibility_off),
          ):null,
          suffixIconColor: Colors.grey.shade500

      ),
    ),
  );
}

Widget generalButton(
    String text,
    {
      required void Function()? func,
      double? size,
      double? leftMargin,
      double? containerSize,
      Color color = AppColors.mainColor,
      Color textColor = AppColors.whiteColor,
      bool isTextButton = true,
      bool isButtonEnabled = true
    }){
  return isTextButton?TextButton(
    onPressed: func, child: Center(
    child: Text(text,
      style: TextStyle(
          fontSize: size ?? 15.sp,
          fontWeight: FontWeight.w900,
          color: color
      ),),
  ),):Container(
    width: containerSize?? 325.w,
    height: 60.h,
    margin: EdgeInsets.only(left: leftMargin?? 12.w),
    padding: EdgeInsets.only(bottom:7.h),
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r)),
    child: InkWell(
      onTap: (){
        isButtonEnabled?
        func!():null;
      },

      child: Center(
        child: Text(text,
          style: TextStyle(
              fontSize: size ?? 15.sp,
              fontWeight: FontWeight.bold,
              color: textColor
          ),),
      ),
    ),
  );
}



Widget page(int index,
    BuildContext context,
    String buttonName,
    String title,
    String title2,
    String subTitle,
    String subTitle2,
    String imagePath,
    PageController pageController){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left:57.w,right: 50.w),
        //color: Colors.red,
        //height: 136.h,
        //width: 315.w,
        child: Center(
          child: Image.asset(
            height: 336.h,
            width: 315.w,
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 52.h,left: 40.w),
        width: 360.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            reusableText(text: title,size: 38.sp,fontFamily: "Poppins",fontWeight: FontWeight.w700),
            reusableText(text: title2,size: 38.sp,fontFamily: "Poppins",fontWeight: FontWeight.w700),

          ],
        ),
      ),
      SizedBox(height: 20.h,),
      Container(
        width: 315.w,
        margin: EdgeInsets.only(left: 40.w,right: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            reusableText(
                text: subTitle,
                color:AppColors.blackShade,
                size: 16.sp,
                fontFamily: "Poppins",

                fontWeight: FontWeight.w500
            ),
            reusableText(
                text: subTitle2,
                color:AppColors.blackShade,
                size: 16.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500
            ),
          ],
        ),
      ),

      GestureDetector(
        onTap: (){
            print("Moving to sign in");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> SignUp()));

          },
        child: Container(
          margin: EdgeInsets.only(top: 68.h,left: 47.w,right: 25.w),
          width: 325.w,
          height: 60.h,
          //color:  Colors.blue,
          decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.all(Radius.circular(20.w)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    //spread radius should be smaller than the blur radius
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0,1)
                )
              ]
          ),
          child: Center(
            child: Text(buttonName,
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal
              ),),
          ),

        ),
      ),

      Container(
        margin: EdgeInsets.only(top: 29.h),
        child: InkWell(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> ReturningUserPage()));

          },
            child: Center(child: reusableText(text: "or Sign in",size: 19.sp,fontWeight: FontWeight.w500))),
      )

    ],
  );
}




Widget pinTextField({
  String? labelText,
  int maxLength = 1,
  required TextEditingController controller,
}) {
  return Expanded(
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: '0',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a digit.';
        }
        return null;
      },
    ),
  );
}

Widget activityIcons({required String logo}){
  return Container(
    padding: EdgeInsets.only(top: 8.h),
    height: 78.h,
    width: 241.w,
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            //color: Colors.blue,
            child: CircleAvatar(
              radius: 30.r,
              backgroundImage: const AssetImage("assets/images/person.png"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h,left: 30.w),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/forward_arrow.png"),
                  Image.asset("assets/images/back_arrow.png")

                ],
              ),
            ),
          ),
          Container(

              padding: EdgeInsets.only(left: 25.w),
              //color: Colors.lightGreenAccent,
              child: Image.asset("assets/images/social_media/$logo",fit: BoxFit.cover,))
        ],
      ),
    ),
  );
}


Widget authorizeAccountTextField({
  required String text,
  double size =20,
  required TextEditingController controller,
  Function(String)? onChangeFunc,
  bool obscureText = false
}){
  return Center(
    child: Container(
      width: 370.w,
      height: 52.h,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10.r)
      ),

      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChangeFunc,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0XFF9747FF)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            //borderSide: BorderSide(color: Colors.grey)
          ),
          hintStyle: TextStyle(
              color: AppColors.greyColor,
              fontSize: size
          ),
          hintText: text,



        ),
      ),
    ),
  );
}