
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webkul_task/helper/Color.dart';
import 'package:webkul_task/helper/app_button.dart';
import 'package:webkul_task/helper/constant.dart';
import 'package:webkul_task/helper/validator.dart';

import '../../provider/signup_provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FocusNode? passFocus, monoFocus,nameFocus, emailFocus = FocusNode();
  final mobileController = TextEditingController();


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
          controller: mobileController,
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
                  color: black.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: textFontSize13),
              fillColor: lightWhite,
              border: InputBorder.none),
          validator: (val) => StringValidation.validateMob(val!, context),
          onSaved: (String? value) {
            context.read<SignupProvider>().mobile = value;
          },
        ),
      ),
    );
  }

  setPass() {
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
          style: TextStyle(
              color: black.withOpacity(0.7),
              fontWeight: FontWeight.bold,
              fontSize: textFontSize13),
          keyboardType: TextInputType.text,
          obscureText: true,
          controller: passwordController,
          textInputAction: TextInputAction.next,
          validator: (val) => StringValidation.validatePass(val, context),
          onSaved: (String? value) {
            context.read<SignupProvider>().password = value;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 5,
            ),
            hintText: 'Password',
            hintStyle: TextStyle(
                color: black.withOpacity(0.3),
                fontWeight: FontWeight.bold,
                fontSize: textFontSize13),
            fillColor: lightWhite,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  setConfirmpss() {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Container(
        height: 53,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: lightWhite,
          borderRadius: BorderRadius.circular(circularBorderRadius10),
        ),
        alignment: Alignment.center,
        child: TextFormField(
          style: TextStyle(
              color: black.withOpacity(0.7),
              fontWeight: FontWeight.bold,
              fontSize: textFontSize13),
          keyboardType: TextInputType.text,
          obscureText: true,
          controller: confirmpassController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password is required';
            }
            if (value != context.read<SignupProvider>().password) {
              return 'Password not match';
            } else {
              return null;
            }
          },
          onSaved: (String? value) {
            context.read<SignupProvider>().confirmPassword = value;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 5,
            ),
            hintText: 'Confirm Password',
            hintStyle: TextStyle(
                color: black.withOpacity(0.3),
                fontWeight: FontWeight.bold,
                fontSize: textFontSize13),
            fillColor: lightWhite,
            border: InputBorder.none,
          ),
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
          controller: nameController,
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
          controller: emailController,
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
            context.read<SignupProvider>().setSingUp(value);
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // skipSignInBtn(),
              _subLogo(),
              welcomeEshopTxt(),
              signUpTxt(),
              setMobileNo(),
              setPass(),
              setConfirmpss(),
              signupBtn()
              // eCommerceforBusinessTxt(),
              // bottomBtn()
            ],
          ),
        ),
      ),
    );
  }
}
