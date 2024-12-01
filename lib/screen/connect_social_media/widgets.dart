import 'package:flutter/material.dart';

import '../../common/entities/colors.dart';

Widget socialMediaButton({String selectedAccount = 'Twitter',required BuildContext context,}){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white, // Background color
      borderRadius: BorderRadius.circular(8), // Border radius
      border: Border.all(color: Color(0XFFD9D9D9)),
    ),
    child: ListTile(
      leading: Image.asset("assets/images/Twitter.png"), // Twitter logo
      title: Text(selectedAccount), // Selected social media account
      trailing: Icon(Icons.keyboard_arrow_down,color: AppColors.mainColor,), // Dropdown icon
      onTap: () {
        // Show a dialog to let the user select the account
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Select Social Media Account"),
              content: DropdownButton<String>(
                //dropdownColor: AppColors.mainColor,
                value: selectedAccount,
                items: <String>['Twitter', 'Facebook', 'Instagram']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                      style: TextStyle(
                          color: Color(0XFF424141)
                      ),),
                  );
                }).toList(),
                // icon: Icon(
                //   Icons.add,
                //   //Icons.keyboard_arrow_down,
                //   color: AppColors.mainColor,
                // ),
                onChanged: (String? newValue) {
                  // setState(() {
                  //   selectedAccount = newValue!;
                  // });
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            );
          },
        );
      },
    ),
  );
}