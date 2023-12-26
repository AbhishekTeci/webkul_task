import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webkul_task/helper/routes.dart';
import 'package:webkul_task/helper/snackbar.dart';
import '../../helper/Color.dart';
import '../../helper/app_button.dart';
import '../../helper/constant.dart';
import '../../helper/validator.dart';
import '../../provider/login_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
//==============================================================================
//============================= Variables Declaration ==========================

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode? passFocus, monoFocus = FocusNode();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//==============================================================================
//============================= INIT Method ====================================
  setStateNow() {
    setState(() {});
  }

  bool isShowPass = true;

  @override
  void initState() {
    super.initState();

    setState(
      () {
        context.read<LoginProvider>().mobileNumberController.text = "";
      },
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

//==============================================================================
//============================= Dispose Method =================================

  @override
  void dispose() {
    context.read<LoginProvider>().buttonController!.dispose();
    super.dispose();
  }

//==============================================================================
//============================= Build Method ===================================

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 23,
            left: 23,
            right: 23,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getLogo(),
                signInTxt(),
                signInSubTxt(),
                setMobileNo(),
                loginBtn(),
                setDontHaveAcc(),
                // termAndPolicyTxt(),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhoneNumber() async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber:
          '+91${context.read<LoginProvider>().mobileNumberController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval of verification code completed.
        // Sign in with the credentials.
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        onFailed('LoginError ${e.message}' ?? 'Verification failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        debugPrint('verificationId $verificationId');
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  onCodeSent(String verificationId) {
    context.read<LoginProvider>().setVerificationId(verificationId);
    Routes.navigateToVerifyOtpView(
        context, context.read<LoginProvider>().mobileNumberController.text);
  }

  onFailed(String message) {
    setSnackbar(message, context);
  }

  Widget setSignInLabel() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'Login',
          style: TextStyle(
            color: primary,
            fontSize: textFontSize30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  setDontHaveAcc() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account? ",
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ubuntu',
                ),
          ),
          InkWell(
            onTap: () {
              Routes.navigateToSignupScreen(context);
            },
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ubuntu',
                  ),
            ),
          )
        ],
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
          controller: context.read<LoginProvider>().mobileNumberController,
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
            context.read<LoginProvider>().setMobileNumber(value);
          },
        ),
      ),
    );
  }

  loginBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: AppBtn(
          title: 'Login',
          btnCntrl: context.read<LoginProvider>().buttonController,
          onBtnSelected: () async {
            if (validateAndSave()) {
              verifyPhoneNumber();
            }
          },
        ),
      ),
    );
  }

  Widget getLogo() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 30),
        child: Image.asset(
          'assets/image/logo.png',
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
        ));
  }

  signInSubTxt() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 13.0,
      ),
      child: Text(
        'Please enter your login details below to start using app.',
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: black.withOpacity(0.38),
              fontWeight: FontWeight.bold,
              fontFamily: 'ubuntu',
            ),
      ),
    );
  }

  signInTxt() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 40.0,
      ),
      child: Text(
        "Welcome to Webkul Movies App",
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: black,
              fontWeight: FontWeight.bold,
              fontSize: textFontSize20,
              letterSpacing: 0.8,
              fontFamily: 'ubuntu',
            ),
      ),
    );
  }
}

setSnackbarScafold(
    GlobalKey<ScaffoldMessengerState> scafoldkey, contex, String msg) {
  scafoldkey.currentState!.showSnackBar(
    SnackBar(
      content: SizedBox(
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: black,
          ),
        ),
      ),
      duration: const Duration(
        seconds: 2,
      ),
      backgroundColor: red,
      behavior: SnackBarBehavior.floating,
      elevation: 1.0,
    ),
  );
}
