import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../finger_print_screen/finger_print.dart';
import '../email_verification_screen/widget.dart';
import 'bloc/create_passcode_bloc.dart';
import 'bloc/create_passcode_event.dart';
import 'bloc/create_passcode_state.dart';


class AuthorizationPasscode extends StatelessWidget {
  AuthorizationPasscode({super.key});

  final TextEditingController pinController = TextEditingController();

  final focusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  final FocusNode _pinFocusNode = FocusNode();

  String pinValue = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          body: BlocListener<CreatePasscodeBloc,CreatePasscodeState>(
              listener: (BuildContext context, state){
                if(state is PasscodeSuccessState){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmPass(passcode: pinController.text)));

               }
            },

            child: Column(
              children: [

                myPinCode(
                    context: context,
                    formKey: formKey,
                    title: 'Create Authorization Passcode',
                    pinController: pinController,
                    onComplete: (){
                      context.read<CreatePasscodeBloc>().add(TriggerPasscodeEvents(passcode: pinController.text));
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmPass()));
                    }
                ),




              ],
            ),
          )),
    );
  }
}

class ConfirmPass extends StatelessWidget {
  final String passcode;
  ConfirmPass({super.key, required this.passcode});

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
            errorText: "Incorrect password",
              context: context,
              formKey: formKey,
              title: "Confirm Passcode ",
              pinController: pinController,
              onComplete: (){
                if(pinController.text == passcode) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          FingerPrintVerify(skip: true, title2: '',)));
                }
              }),

        ],
      ),
    );
  }
}

