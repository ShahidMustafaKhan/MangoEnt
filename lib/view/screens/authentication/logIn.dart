import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/appButton.dart';
import 'package:teego/view/widgets/app_text_field.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view/widgets/social_button.dart';
import 'package:teego/view/widgets/validation_checker.dart';
import 'package:teego/view_model/auth_controller.dart';

import '../../../data/app/constants.dart';

class LogIn extends StatefulWidget {
  const LogIn();

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late TextEditingController name;
  late TextEditingController password;
  RxBool isPasswordObscure = false.obs;
  final _formKey = GlobalKey<FormState>();
  RxBool isFormDirty = false.obs;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late SharedPreferences preferences;
  AuthViewModel authViewModel= Get.put(AuthViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = TextEditingController();
    password = TextEditingController();
    initSharedPref();
  }

  @override
  void dispose() {
    name.dispose();
    password.dispose();
    super.dispose();
  }

  initSharedPref() async {
    preferences = await SharedPreferences.getInstance();
    Constants.queryParseConfig(preferences);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      padding: EdgeInsets.all(Dimension.borderRadius),
      body: SingleChildScrollView(
        child: Obx(() {
          return Form(
            key: _formKey,
            autovalidateMode: isFormDirty.value ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome\nBack!",
                      style: sfProDisplayBold.copyWith(fontSize: 36),
                    )),
                SizedBox(
                  height: 24.h,
                ),
                AppTextFormField(
                    controller: name,
                    isPrefixIcon: true,
                    txtColor: AppColors.yellow,
                    textInputAction: TextInputAction.next,
                    autoValidateMode: AutovalidateMode.disabled,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                          "assets/svg/person.svg"),
                    ),
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      } else if (UsernameChecker.isNotValid(value)){
                        return 'Username must be 3-20 characters & cannot start with number';
                      }
                      return null;
                    },
                    hintText: "Username"),
                SizedBox(
                  height: 24.h,
                ),
                AppTextFormField(
                    controller: password,
                    txtColor: AppColors.yellow,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    isObSecure: isPasswordObscure.value,
                    isPrefixIcon: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                          "assets/svg/lock.svg"),
                    ),
                    autoValidateMode: AutovalidateMode.disabled,
                    isSuffixIcon: true,
                    suffixIcon: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: AppColors.dHintColor,
                      onPressed: () {
                        isPasswordObscure.value = !isPasswordObscure.value;
                      },
                      icon: Icon(isPasswordObscure.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    ),
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (PasswordChecker.isNotValid(value)){
                        return 'Password should be 8+ characters with at least 1 number';
                      }
                      return null;
                    },
                    hintText: "Password"),
                SizedBox(
                  height: 6.h,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.forgotPassword);
                        },
                        child: Text("Forgot Password?",
                            style: sfProDisplayRegular.copyWith(fontSize: 12, color: AppColors.yellow)))),

                SizedBox(
                  height: 90.h,
                ),
                AppButton(context, "LogIn", () {
                  if(_formKey.currentState!.validate()){
                    // Get.snackbar('VALIDATION', 'Login Fields are validated.');
                    authViewModel.signInWithUserName(context, preferences, name.text, password.text);
                  } else {
                    isFormDirty.value = true;
                  }
                }),
                SizedBox(
                  height: 90.h,
                ),
                Text("- OR Continue with -",
                    style: sfProDisplayRegular.copyWith(color: AppColors.dHintColor, fontSize: 12)),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SocialButton(
                      path: "assets/svg/google.svg",
                      onTap: (){
                        authViewModel.signInWithGoogle(_googleSignIn, firebaseAuth, context, preferences);
                      },
                    ),
                    SocialButton(
                      path: "assets/svg/apple.svg",
                      onTap: (){},
                    ),
                    SocialButton(
                      path: "assets/svg/fb.svg",
                      onTap: (){},
                    ),
                    SocialButton(
                      path: "assets/svg/tiktok.svg",
                      onTap: (){},
                    ),
                    SocialButton(
                      path: "assets/svg/twitch.svg",
                      onTap: (){},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "I don’t have an account ",
                    style: sfProDisplayRegular.copyWith(color: AppColors.dHintColor, fontSize: 14)),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.createAccount);
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Create an account',
                                style: sfProDisplayMedium
                                    .copyWith(
                                  fontSize: 14,
                                  color: AppColors.yellow,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.yellow,
                                  decorationStyle: TextDecorationStyle.solid,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Row(
                //   children: [
                //     Text("I don’t have an account",style: Theme.of(context).textTheme.bodyMedium,),
                //     Text("I don’t have an account"),
                //   ],
                // )
              ],
            ),
          );
        }),
      ),
    );
  }
}
