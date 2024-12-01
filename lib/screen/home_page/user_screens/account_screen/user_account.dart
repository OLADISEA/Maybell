import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/entities/colors.dart';
import '../../../../common/widgets/widget.dart';
import '../../../../data/repository/user_tokens.dart';
import '../../../connect_social_media/add_account_to_maybell/connect_social_media.dart';
import 'account_card/account_card.dart';
import 'bloc/user_account_bloc.dart';
import 'bloc/user_account_event.dart';
import 'bloc/user_account_state.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  String mimiId = '';
  String? username;
  @override
  void initState() {
    //context.read<UserAccountBloc>().add(TriggerUserAccount());
    super.initState();
    fetchUserName();
  }


  Future<void> fetchUserName() async {
    String? username = await AccessTokenProvider.getUserName();

    if (username != null) {
      print("Username: $username");
    } else {
      print("Username not found");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 38.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 106.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: Center(
                          child: reusableText(
                            text: "My Accounts",
                            size: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 50.w,),
                      Image.asset("assets/images/menu_icon.png")
                    ],
                  ),
                ),
                SizedBox(height: 38.h,),
                Padding(
                  padding: EdgeInsets.only(left: 26.w,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText(text: "My Accounts"),
                      SizedBox(height: 14.h,),
                      BlocConsumer<UserAccountBloc, UserAccountState>(
                        builder: (BuildContext context, UserAccountState state) {
                          if (state is UserAccountLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is UserAccountLoadedState) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.userAccounts.length,
                              itemBuilder: (context, index) {
                                String socialMediaName = state.userAccounts[index].socialMediaName;
                                if(socialMediaName =="mimi-chat"){
                                  print('this is true');
                                  mimiId = state.userAccounts[index].id;
                                  setId();
                                }
                                return AccountCard(
                                  name: username == null?"@stevie_wond": "@$username",
                                  image: "user_pic.png",
                                  socialMediaLogo: "social_media/instagram2.png",
                                  socialMediaName: state.userAccounts[index].socialMediaName,
                                );
                              },
                            );
                          }
                          return Container();
                        }, listener: (BuildContext context, UserAccountState state) async{
                          if(state is UserAccountLoadedState){
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            print('the mimi id is ${prefs.get("mimi_id")}');
                            if(prefs.getString("mimi_id") == null){
                              prefs.setString("mimi_id", mimiId);
                              print(prefs.getString("mimi_id"));
                            }
                          }
                      },
                      ),
                      SizedBox(height: 137.h,),
                      Center(
                        child: FloatingActionButton(
                          backgroundColor: AppColors.mainColor,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ConnectAccount()));
                          },
                          child: const Icon(
                            Icons.add,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
  void setId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('the mimi id is ${prefs.get("mimi_id")}');
    if(prefs.getString("mimi_id") == null){
      prefs.setString("mimi_id", mimiId);
      print(prefs.getString("mimi_id"));
    }
  }
}
