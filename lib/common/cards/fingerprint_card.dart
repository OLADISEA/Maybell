import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';

import '../entities/colors.dart';
import '../widgets/widget.dart';

class FingerPrintCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final String title2;
  final bool skip;
  final void Function() onTap;
  final Function()? moveToPasscode;
  const FingerPrintCard({super.key,
    required this.title,
    required this.subTitle,
    required this.title2, required this.skip, required this.onTap, this.moveToPasscode});

  @override
  State<FingerPrintCard> createState() => _FingerPrintCardState();
}

class _FingerPrintCardState extends State<FingerPrintCard> {

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
  }


  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
        widget.title2,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });

    if (authenticated) {
      // Navigate to another page when authenticated
      widget.onTap();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333.w,
          margin: EdgeInsets.only(left: 74.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 154.h,),
              Container(
                width: 92.w,
                height: 110.h,
                //color: Colors.red,
                margin: EdgeInsets.only(left: 91.w),
                child: InkWell(
                  onTap: _authenticateWithBiometrics,
                  child: Image.asset("assets/images/fingerprint.png"),
                ),
              ),
              SizedBox(height: 42.h,),
              Container(
                margin: EdgeInsets.only(left: 20.w),
                //color: Colors.red,
                width: 353.w,
                height: 30.h,
                  child: reusableText(text: widget.title,size: 24.sp,fontFamily: "Calibri",fontWeight: FontWeight.w400)),
              SizedBox(height: 122.h,),

              Center(
                child: widget.skip?Container():reusableText(text: "Skip",color: AppColors.mainColor,size: 25,fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 200.h,),
              Container(
                margin: EdgeInsets.only(left: 61.w),
                child: InkWell(
                  onTap: (){
                    widget.moveToPasscode?.call();
                  },
                  child: reusableText(text: widget.subTitle,size: 16,color: AppColors.mainColor,fontWeight: FontWeight.w400),
                ),
              )


            ],
          ),
        );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}