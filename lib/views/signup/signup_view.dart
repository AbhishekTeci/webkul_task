
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webkul_task/helper/Color.dart';
import 'package:webkul_task/helper/app_button.dart';
import 'package:webkul_task/helper/constant.dart';
import 'package:webkul_task/helper/routes.dart';
import 'package:webkul_task/helper/snackbar.dart';
import 'package:webkul_task/helper/validator.dart';
import 'package:webkul_task/provider/login_provider.dart';

import '../../provider/signup_provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  FocusNode? passFocus, monoFocus,nameFocus, emailFocus = FocusNode();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();



  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode? nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _subLogo() {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: height * 0.15),
      child: Image.asset(
        'assets/image/logo.png',
        height: 150,
        width: 150,
        fit: BoxFit.contain,
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

  welcomeEshopTxt() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 30.0),
      child: Text(
        'Welcome User',
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
          color: black,
          fontWeight: FontWeight.bold,
          fontFamily: 'ubuntu',
        ),
      ),
    );
  }

  setMobileNo() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        height: 53,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: lightWhite,
          borderRadius: BorderRadius.circular(circularBorderRadius10),
        ),
        alignment: Alignment.center,
        child: TextFormField(
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(passFocus);
          },
          style: TextStyle(
              color: black.withOpacity(0.7),
              fontWeight: FontWeight.bold,
              fontSize: textFontSize13),
          keyboardType: TextInputType.number,
          controller: context.read<SignupProvider>().mobileController,
          focusNode: monoFocus,
          textInputAction: TextInputAction.next,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 5,
              ),
              hintText: 'Mobile Number',
              hintStyle: TextStyle(
                  color: black.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: textFontSize13),
              fillColor: lightWhite,
              border: InputBorder.none),
          validator: (val) => StringValidation.validateMob(val!, context),
          onSaved: (String? value) {
            context.read<SignupProvider>().setMobileNumber(value);
          },
        ),
      ),
    );
  }


  signupBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: AppBtn(
          title:'Signup',
          btnCntrl: context.read<SignupProvider>().buttonController,
          onBtnSelected: () async {
            if (validateAndSave()) {
              signInWithPhoneNumber();
            }
          },
        ),
      ),
    );
  }

  signUpTxt() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 40.0,
      ),
      child: Text(
        'Signup',
        style: Theme.of(context).textTheme.headline6!.copyWith(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: textFontSize23,
          fontFamily: 'ubuntu',
          letterSpacing: 0.8,
        ),
      ),
    );
  }


  Future<void> signInWithPhoneNumber() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: context.read<LoginProvider>().getVerificationId,
        smsCode: context.read<LoginProvider>().getOtpValue,
      );
      UserCredential result = await _firebaseAuth.signInWithCredential(credential);
      onSignInSuccess(result.user!);
    } catch (e) {
      debugPrint(e.toString());
      onSignInFailed();
    }
  }

  onSignInSuccess(User){
    Routes.navigateToVerifyOtpView(context,context.read<SignupProvider>().mobileController.text);
    setSnackbar('SigIn In Success', context);
  }

  onSignInFailed(){
   setSnackbar('SigIn In failed', context);
  }

  setUserName() {
    return Padding(
      padding: const EdgeInsets.only(top:20),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(circularBorderRadius10),
        ),
        alignment: Alignment.center,
        child: TextFormField(
          style: TextStyle(
              color: fontColor.withOpacity(0.7),
              fontWeight: FontWeight.bold,
              fontSize: textFontSize13),
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          controller: context.read<SignupProvider>().nameController,
          focusNode: nameFocus,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Name',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 5,
            ),
            hintText: 'Name',
            hintStyle: TextStyle(
                color: fontColor.withOpacity(0.3),
                fontWeight: FontWeight.bold,
                fontSize: textFontSize13),
            fillColor: lightWhite,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(circularBorderRadius10),
                borderSide: const BorderSide(color: primary)
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius:  BorderRadius.circular(circularBorderRadius10),
              borderSide: const BorderSide(color: primary ),

            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(circularBorderRadius10),
              borderSide: const BorderSide(color: primary, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(circularBorderRadius10),
              borderSide: const BorderSide(color: Color(0xffE64646) ),

            ),
            disabledBorder: InputBorder.none,
          ),
          validator: (val) => StringValidation.validateUserName(
              val!,
              'User Name is required',
              'Incorrect User Namw'),
          onSaved: (String? value) {
            context.read<SignupProvider>().setUserName(value);
          },
          onFieldSubmitted: (v) {
            _fieldFocusChange(context, nameFocus!, emailFocus);
          },
        ),
      ),
    );
  }

  setEmail() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        // height: 53,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(circularBorderRadius10),
        ),
        alignment: Alignment.center,
        child: TextFormField(
          style: TextStyle(
              color: fontColor.withOpacity(0.7),
              fontWeight: FontWeight.bold,
              fontSize: textFontSize13),
          keyboardType: TextInputType.emailAddress,
          focusNode: emailFocus,
          textInputAction: TextInputAction.next,
          controller: context.read<SignupProvider>().emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 5,
            ),
            hintText: 'Email',
            hintStyle: TextStyle(
                color:
                fontColor.withOpacity(0.3),
                fontWeight: FontWeight.bold,
                fontSize: textFontSize13),
            fillColor: lightWhite,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(circularBorderRadius10),
                borderSide: const BorderSide(color: primary)
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius:  BorderRadius.circular(circularBorderRadius10),
              borderSide: const BorderSide(color: primary ),

            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(circularBorderRadius10),
              borderSide: const BorderSide(color: primary, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(circularBorderRadius10),
              borderSide: const BorderSide(color: Color(0xffE64646) ),

            ),
            disabledBorder: InputBorder.none,
          ),
          validator: (val) => StringValidation.validateEmail(
            val!,
            'Email is required',
            'Invalid email',
          ),
          onSaved: (String? value) {
            context.read<SignupProvider>().setSingUpEmail(value);
          },
          onFieldSubmitted: (v) {
            _fieldFocusChange(
              context,
              emailFocus!,
              passFocus,
            );
          },
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsetsDirectional.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _subLogo(),
                welcomeEshopTxt(),
                signUpTxt(),
                setUserName(),
                setEmail(),
                setMobileNo(),
                signupBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
