import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/widgets/appButton.dart';
import 'package:teego/view/widgets/base_scaffold.dart';

class PasswordChanged extends StatefulWidget {
  const PasswordChanged();

  @override
  State<PasswordChanged> createState() => _PasswordChangedState();
}

class _PasswordChangedState extends State<PasswordChanged> {
  late TextEditingController email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 120),
            SvgPicture.asset("assets/svg/Star.svg"),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Reset Password",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  "A password reset link has been sent \nto your email address.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            AppButton(context, "Back to login", () {
              Get.toNamed(AppRoutes.login);
            }),
          ],
        ),
      ),
    );
  }
}
