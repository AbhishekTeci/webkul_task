

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:webkul_task/helper/routes.dart';

import '../../Helper/Constant.dart';
import '../../helper/Color.dart';
import '../../helper/app_button.dart';
import '../../helper/design_confg.dart';
import '../../provider/login_provider.dart';

class VerifyOtp extends StatefulWidget {
String mobileNo;
   VerifyOtp({super.key,required this.mobileNo});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}


Widget getLogo() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 20),
    child: Image.asset(
      DesignConfiguration.setPngPath('logo'),
      alignment: Alignment.center,
      height: 150,
      width: 150,
      fit: BoxFit.contain,
    ),
  );
}



class _VerifyOtpState extends State<VerifyOtp> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();




  otpLayout() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 30),
      child: PinFieldAutoFill(
        decoration: BoxLooseDecoration(
          textStyle: const TextStyle(
              fontSize: textFontSize20,
              color: fontColor),
          radius: const Radius.circular(circularBorderRadius4),
          gapSpace: 15,
          bgColorBuilder: const FixedColorBuilder(white),
          strokeColorBuilder: const FixedColorBuilder(primary),
        ),
        currentCode: context.read<LoginProvider>().otp,
        codeLength: 6,
        controller: context.read<LoginProvider>().otpController,
        onCodeChanged: (String? code) {
          context.read<LoginProvider>().setOtpValue(code);
        },
        enableInteractiveSelection: true,
        autoFocus: true,
        cursor: Cursor(
          width: 2,
          height: 40,
          color: fontColor,
          radius: const Radius.circular(1),
          enabled: true,
        ),
        onCodeSubmitted: (String code) {
          context.read<LoginProvider>().setOtpValue(code);
        },
      ),
    );
  }

  bool validateAndSave() {
    final form = _formkey.currentState!;
    form.save();
    if (form.validate()) {
      return true;
    }
    return false;
  }

  monoVarifyText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 60.0,
      ),
      child: Text(
        'Just the last Step!',
        style: Theme.of(context).textTheme.headline6!.copyWith(
          color: fontColor,
          fontWeight: FontWeight.bold,
          fontSize: textFontSize23,
          letterSpacing: 0.8,
          fontFamily: 'ubuntu',
        ),
      ),
    );
  }

  otpText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 13.0,
      ),
      child: Text(
        'We have sent a verification code',
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
          color: fontColor.withOpacity(0.5),
          fontWeight: FontWeight.bold,
          fontFamily: 'ubuntu',
        ),
      ),
    );
  }

  subText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 13.0,
      ),
      child: Text(
       'Please be patient while we verify you',
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
          color:fontColor.withOpacity(0.7),
          fontWeight: FontWeight.bold,
          fontFamily: 'ubuntu',
        ),
      ),
    );
  }

  mobText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 5.0),
      child: Text(
        '+91-${widget.mobileNo}',
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
          color: fontColor.withOpacity(0.5),
          fontWeight: FontWeight.bold,
          fontFamily: 'ubuntu',
        ),
      ),
    );
  }

  verifyBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: AppBtn(
          title:'Continue',
          onBtnSelected: () async {
            if(validateAndSave()){
              Routes.navigateToDashboard(context);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: 23,
              left: 23,
              right: 23,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getLogo(),
                monoVarifyText(),
                subText(),
                otpText(),
                mobText(),
                otpLayout(),
                verifyBtn(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
