import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/appButton.dart';
import 'package:teego/view/widgets/app_text_field.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view/widgets/validation_checker.dart';

import '../../../view_model/auth_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword();

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController email;
  final _formKey = GlobalKey<FormState>();
  AuthViewModel authViewModel= Get.put(AuthViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      padding: EdgeInsets.all(Dimension.borderRadius),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forgot\npassword?",
                  style: Theme.of(context).textTheme.titleLarge,
                )),
            SizedBox(
              height: 24.h,
            ),
            AppTextFormField(
                controller: email,
                isPrefixIcon: true,
                txtColor: AppColors.yellow,
                textInputAction: TextInputAction.done,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                prefixIcon: Icon(Icons.email, color: AppColors.dHintColor),
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (EmailChecker.isNotValid(value)){
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                hintText: "Enter your Email"),
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                ),
                Expanded(
                  child: Text(
                    " We will send you a message to set or reset your new password",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 90.h,
            ),
            AppButton(context, "Submit", () {
              if(_formKey.currentState!.validate()){
                authViewModel.forgetPassword(email.text, context);

              }
            }),
            const SizedBox(
              height: 16,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Remember Password ? ",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400, color: AppColors.dHintColor),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.login);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Login',
                            style:
                                Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
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
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
