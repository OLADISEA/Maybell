import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/entities/colors.dart';
import '../../log_in_page/log_in_page.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 500.h,),
          GestureDetector(
            onTap: () {
              _showSignOutConfirmationDialog(context);
            },
            child: Container(
              margin: EdgeInsets.only(left: 113.w),
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: AppColors.mainColor, // Change the border color as needed
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white, // Change the background color as needed
              ),
              child: const Center(
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black, // Change the text color as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showSignOutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async{
                final prefs = await SharedPreferences.getInstance();
                // Perform sign out logic here
                await prefs.setBool('isLoggedOut',true);
                await prefs.setBool("isLoggedIn", false);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignIn()));
                // Navigator.of(context).popUntil((route) => route.isFirst);
                // This will pop all routes until the first one (i.e., sign-in page)
              },
              child: Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

}
