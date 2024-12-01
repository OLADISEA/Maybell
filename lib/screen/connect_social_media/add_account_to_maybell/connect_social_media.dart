import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/entities/colors.dart';
import '../../../common/widgets/widget.dart';
import '../authorization/authorize_social_media.dart';
import 'bloc/add_account_bloc.dart';
import 'bloc/add_account_event.dart';
import 'bloc/add_account_state.dart';


class ConnectAccount extends StatelessWidget {
  const ConnectAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 31,right: 31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            reusableText(text: "Which Social Media account",color: Color(0XFF2C2D2F),fontWeight: FontWeight.w500),
            reusableText(text: "would you like maybell to secure",color: Color(0XFF2C2D2F),fontWeight: FontWeight.w500),
            SizedBox(height: 53),
            // Social Media Account Selection Button
            SocialMediaAccountButton(),


          ],
        ),
      ),
    );
  }
}

class SocialMediaAccountButton extends StatefulWidget {
  const SocialMediaAccountButton({super.key});

  @override
  _SocialMediaAccountButtonState createState() =>
      _SocialMediaAccountButtonState();
}

class _SocialMediaAccountButtonState extends State<SocialMediaAccountButton> {
  String selectedAccount = 'mimi-chat'; // Default selected account

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddSocialMediaNameBloc,AddSocialMediaNameState>(
      listener: (context, state){
        if(state is SocialMediaNameSuccessState){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AuthorizeAccount(selectedAccount:selectedAccount)));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0XFFD9D9D9), // Background color
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
                        items: <String>['mimi-chat', 'revel-room','blink', 'duo-connect']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                              style: TextStyle(
                                color: Color(0XFF424141),
                              ),),
                          );
                        }).toList(),
                        // icon: Icon(
                        //   Icons.add,
                        //   //Icons.keyboard_arrow_down,
                        //   color: AppColors.mainColor,
                        // ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAccount = newValue!;
                          });
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 45,),
          generalButton("Add account",size: 24,isTextButton: false,func: () {
            context.read<AddSocialMediaNameBloc>().add(AddSocialMediaNameToMayBell(socialMediaName: selectedAccount));
          }),

        ],
      ),
    );
  }
}
