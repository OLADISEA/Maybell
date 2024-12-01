import 'package:flutter/material.dart';

import '../../../../common/cards/success_card.dart';
import '../../../../common/widgets/widget.dart';
import '../../../home_page/home_page.dart';
import '../../../sign_up_screen/verification/email_verification_screen/widget.dart';


class AuthorizationPass extends StatelessWidget {
  AuthorizationPass({super.key});

  final TextEditingController pinController = TextEditingController();

  final focusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  final FocusNode _pinFocusNode = FocusNode();

  String pinValue = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          body: Column(
            children: [

              myPinCode(
                  context: context,
                  formKey: formKey,
                  title: 'Enter Your Passcode',
                  pinController: pinController,
                  onComplete: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmPass()));
                  }
              ),

              Center(
                child: InkWell(
                  onTap: (){},
                  child: reusableText(text: "Forgot passcode"),
                ),
              )



            ],
          )),
    );
  }
}

class ConfirmPass extends StatelessWidget {
  ConfirmPass({Key? key}) : super(key: key);

  final TextEditingController pinController = TextEditingController();

  final focusNode = FocusNode();

  final formKey = GlobalKey<FormState>();
  final FocusNode _pinFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          myPinCode(
              context: context,
              formKey: formKey,
              title: "Confirm Passcode ",
              pinController: pinController,
              onComplete: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Success(
                  successIcon: 'checked.png',
                  text: 'Login Approved!', onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
                },)));
              }),

        ],
      ),
    );
  }
}




