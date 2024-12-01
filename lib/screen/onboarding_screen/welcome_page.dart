import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/widgets/widget.dart';
import '../connect_social_media/add_account_to_maybell/connect_social_media.dart';
import 'bloc/welcome_bloc.dart';
import 'bloc/welcome_events.dart';
import 'bloc/welcome_states.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc, WelcomeStates>(
            builder: (context, state){
              return Container(
                margin: EdgeInsets.only(top: 39.h),
                //width: 375.w,
                child: Stack(
                  children: [
                    Container(
                      //color: Colors.red,
                      margin: EdgeInsets.only(left: 107.w),
                      padding: EdgeInsets.only(right: 133.w),
                      child: appLogo(showDisplay: true),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 102.h),
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (index){
                          state.counter = index;
                          BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvents());

                        },
                        children: [
                          page(
                              1,
                              context,
                              "Create an account",
                              "Secure your social",
                              "media accounts",
                              "explore a variety of options for safeguarding",
                              "your social media accounts",
                              "assets/images/amico.png",
                              pageController
                          ),
                          page(
                              2,
                              context,
                              "Create an account",
                              "Protect your identity",
                              "& Passwords",
                              "explore a variety of options for safeguarding",
                              "your social media accounts",
                              "assets/images/amico2.png",
                              pageController

                          ),
                          page(
                              3,
                              context,
                              "Create an account",
                              "We keep you safe",
                              "While you're away",
                              "explore a variety of options for safeguarding",
                              "your social media accounts",
                              "assets/images/bro.png",
                              pageController

                          ),

                        ],
                      ),
                    ),
                    Positioned(
                        top: 650.h,
                        left: 186.w,
                        //bottom: 170.h,
                        child: DotsIndicator(
                          position: state.counter.toInt(),
                          dotsCount: 3,
                          mainAxisAlignment: MainAxisAlignment.center,
                          decorator: DotsDecorator(
                              color: Color(0XFF75767B),
                              activeColor: Color(0XFF7E57C2),
                              size: Size.square(10.w),
                              activeSize: Size(20.0.w,6.0.h),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              )
                          ),
                        ))
                  ],
                ),
              );}
        ),
      ),
    );
  }

}


class GettingStarted extends StatelessWidget {
  const GettingStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 197,),
            reusableText(text: "Getting Started",fontWeight: FontWeight.w600,size: 32),
            SizedBox(height: 22,),
            reusableText(text: "Answer some questions to get started",size: 19),
            SizedBox(height: 37,),
            Image.asset("assets/images/pana.png"),
            SizedBox(height: 63,),
            generalButton("Continue",isTextButton: false,size: 24, func: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ConnectAccount()));
            })

          ],
        ),
      ),
    );
  }
}


