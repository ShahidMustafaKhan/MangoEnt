import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/view/widgets/social_button.dart';
import 'package:teego/view/widgets/validation_checker.dart';

import '../../../data/app/constants.dart';
import '../../../view_model/auth_controller.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late TextEditingController name;
  late TextEditingController confirmPassword;
  late TextEditingController password;
  RxBool isChecked = false.obs;
  final _formKey = GlobalKey<FormState>();
  RxBool isFormDirty = false.obs;
  RxBool isPasswordObscure = false.obs;
  RxBool isConfirmPasswordObscure = false.obs;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late SharedPreferences preferences;
  AuthViewModel authViewModel= Get.put(AuthViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = TextEditingController();
    confirmPassword = TextEditingController();
    password = TextEditingController();
    initSharedPref();
  }

  @override
  void dispose() {
    name.dispose();
    confirmPassword.dispose();
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
      padding: EdgeInsets.only(left: Dimension.borderRadius, right: Dimension.borderRadius ),
      body: SingleChildScrollView(
        child: Obx((){
          return Form(
            key: _formKey,
            autovalidateMode: isFormDirty.value ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
            child: Column(
              children: [
                SizedBox(height: Dimension.borderRadius,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Create an\naccount",
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
                    textInputAction: TextInputAction.next,
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
                  height: 24.h,
                ),
                AppTextFormField(
                    controller: confirmPassword,
                    isPrefixIcon: true,
                    txtColor: AppColors.yellow,
                    textInputAction: TextInputAction.done,
                    autoValidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.visiblePassword,
                    isObSecure: isConfirmPasswordObscure.value,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                          "assets/svg/lock.svg"),
                    ),
                    isSuffixIcon: true,
                    suffixIcon: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: AppColors.dHintColor,
                      onPressed: () {
                        isConfirmPasswordObscure.value = !isConfirmPasswordObscure.value;
                      },
                      icon: Icon(isConfirmPasswordObscure.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter confirm password';
                      } else if (value != password.text) {
                        return 'The password you entered is different.';
                      }
                      return null;
                    },
                    hintText: "Confirm Password"),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          isChecked.value = !isChecked.value;
                        },
                        child: Container(
                          width: 14.0,
                          height: 14.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.yellow, // Border color
                            ),
                            color: isChecked.value
                                ? AppColors.yellow
                                : Colors.transparent, // Fill color when checked
                          ),
                          child: isChecked.value
                              ? const Center(
                            child: Icon(
                              Icons.check_sharp,
                              size: 12.0,
                              color: Colors.black, // Checkmark color
                            ),
                          )
                              : null,
                        ),
                      ),
                    ),
                    Wrap(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: '  By clicking the',
                                  style: sfProDisplayRegular.copyWith(color: AppColors.dHintColor, fontSize: 12)),
                              TextSpan(
                                  text: ' Register ',
                                  style: sfProDisplayRegular.copyWith(color: AppColors.yellow, fontSize: 12)),
                              TextSpan(
                                  text: 'button, you agree to the\npublic offer',
                                  style: sfProDisplayRegular.copyWith(color: AppColors.dHintColor, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 90.h,
                ),
                AppButton(context, "Create Account", () {
                  if(_formKey.currentState!.validate()){
                    authViewModel.signUpWithUserName(context, preferences, name.text, password.text);
                  } else {
                    isFormDirty.value = true;
                  }
                }),
                SizedBox(
                  height: 90.h,
                ),
                Text("- OR Continue with -",
                    style: sfProDisplayRegular.copyWith(color: AppColors.dHintColor, fontSize: 12)),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SocialButton(
                      path: "assets/svg/google.svg",
                      onTap: (){
                        authViewModel.signUpWithGoogle(_googleSignIn, firebaseAuth, context, preferences);
                      },
                    ),
                    SocialButton(
                      path: "assets/svg/apple.svg",
                      onTap: (){
                        authViewModel.signupWithApple(context);
                      },
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
                SizedBox(
                  height: 32.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "I already have an account ",
                    style: sfProDisplayRegular.copyWith(color: AppColors.dHintColor, fontSize: 14)),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.login);
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Login',
                                style: sfProDisplayBold
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
                SizedBox(height: isFormDirty.value ? Dimension.borderRadius : 0,)
              ],
            ),
          );
        }),
      ),
    );
  }
}
