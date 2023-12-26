
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class LoginProvider extends ChangeNotifier {
  String? mobile, password, username, id,otp;
  AnimationController? buttonController;
  TextEditingController otpController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  String errorMessage = '';
  String _verificationId = '';

  get getMobilenumber => mobile;
  get getVerificationId => _verificationId;




  get getOtpValue => otp;

  setOtpValue(String? value){
    otp= value;
    notifyListeners();
  }

  setVerificationId(String verificationId){
    _verificationId = verificationId;
    notifyListeners();
  }

  setMobileNumber(String? value){
    mobile = value;
    notifyListeners();
  }


//   Future<void> sentOTP(String mobile,{bool fromSingUp,TextEditingController controller}) async {
//     _isLoading = true;
//     FirebaseAuth.instance.setSettings(
//       appVerificationDisabledForTesting: true
//
//     );
//
//      if(!GetPlatform.isWeb) {
//        await FirebaseAuth.instance.verifyPhoneNumber(
//          phoneNumber: mobile,
//          timeout: fromSingUp ? Duration(seconds: 80) : Duration(seconds: 80),
//          verificationCompleted: (PhoneAuthCredential credential) {
//            code.value = credential.smsCode;
//            debugPrint("sms" + credential.smsCode);
//          },
//          verificationFailed: (FirebaseAuthException e) {
//            _isLoading = false;
//            update();
//            debugPrint("Firebase Auth error" + e.code);
//
//            showCustomSnackBar('please_try_after_sometime'.tr.capitalizeFirst);
//
//            Get.back();
//          },
//          codeSent: (String verificationId, int resendToken) async {
//            _isLoading = false;
//            update();
//            // controller.clear();
//            showCustomSnackBar('otp_sent'.tr, isError: false);
//            //  mobileNumber=mobile;
//            _resendToken = resendToken;
//
//            verificationID = verificationId;
//            // if(fromSingUp==false){
//            //   Get.toNamed(RouteHelper.getVerificationRoute(mobile, '', RouteHelper.forgotPassword,));
//            // }
//
//
//          },
//          forceResendingToken: _resendToken,
//          codeAutoRetrievalTimeout: (String verificationId) {
//            _isLoading = false;
//          },
//
//        );
//      }else{
//        FirebaseAuth auth = FirebaseAuth.instance;
//
// // Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
//        ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(mobile);
//        confirmationResult.confirm(verificationCode);
//      }//            update();
//            verificationID = verificationId;
//
//
//
//
//     _isLoading = false;
//     update();
//
//   }
//
//   Future<void> verifyOTP( String token,BuildContext context,{bool fromSingUp,String phoneNumber,TextEditingController controller}) async {
//     _isLoading = true;
//     update();
//
//     // try {
//     //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
//     //     verificationId: verificationID,
//     //     smsCode: pin,);
//     //   _isLoading = true;
//     //   update();
//     //   final authCredential = await FirebaseAuth.instance.signInWithCredential(
//     //       credential);
//     //   if (authCredential.user != null) {
//
//     if (fromSingUp == true) {
//       debugPrint("verify sucess");
//       signUpBody.otp=verificationCode;
//
//       await registration(signUpBody).then((status) async {
//         if (status.isSuccess) {
//           _isLoading = true;
//           update();
//           Get.toNamed(
//               RouteHelper.getAccessLocationRoute(RouteHelper.signUp));
//
//           MixPanel.setEvents("user signUp",propertiesName: "userName",properties:signUpBody.fName );
//         } else {
//           controller.text = "";
//           showCustomSnackBar(status.message);
//
//
//
//         }
//       });
//       // _isLoading = false;
//       // update();
//     } else if (fromSingUp != true) {
//       _isLoading = true;
//       debugPrint("verify sucess");
//       await login(phoneNumber).then((status) async {
//
//         if (status.isSuccess) {
//           // if (isActiveRememberMe) {
//           //   authController.saveUserNumberAndPassword(_phone, _password, countryDialCode);
//           // } else {
//           //   authController.clearUserNumberAndPassword();
//           // }
//           //String _token = status.message.substring(1, status.message.length);
//           if (Get
//               .find<SplashController>()
//               .configModel
//               .customerVerification &&
//               int.parse(status.message[0]) == 0) {
//
//           } else {
//             _isLoading = true;
//             update();
//             //showCustomSnackBar(status.code, isError: false);
//             await Get.find<UserController>().getUserInfo();
//             Get.find<UserController>().userInfoModel;
//             MixPanel.setEvents("user Login",propertiesName: "userName",properties:Get.find<UserController>().userInfoModel.fName );
//             Get.toNamed(RouteHelper.getAccessLocationRoute('sign-in'));
//           }
//         } else {
//           showCustomSnackBar(status.message);
//         }
//       });
//     }
//     //   } else {
//     //
//     //     update();
//     //     showCustomSnackBar("Wrong OTP");
//     //    controller.clear();
//     //     _isLoading = false;
//     //     update();
//     //   }
//     //   _isLoading = false;
//     //   update();
//     // } on FirebaseAuthException catch (e) {
//     //   _isLoading = false;
//     //   update();
//     //   controller.clear();
//     //   showCustomSnackBar("Wrong OTP");
//     //   debugPrint(e.message.toString());
//     // }
//
//
//     _isLoading = false;
//     update();
//
//   }






}
