import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../widgets/custom_buttons.dart';

class AudienceListSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.close, color: Colors.transparent),
                Text(
                  'Audience',
                  style: sfProDisplaySemiBold.copyWith(fontSize: 24),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  colors: [
                    AppColors.orangeContainer,
                    AppColors.progressLinearOrangeColor1,
                  ],
                ),
              ),
              child: Row(
                children: [
                  Text('Join For Exclusive Privileges', style: sfProDisplayRegular.copyWith(fontSize: 16)),
                  const Spacer(),
                  PrimaryButton(
                    width: 100,
                    height: 40,
                    title: 'Subscribe',
                    bgColor: Colors.white,
                    textStyle: sfProDisplayBold.copyWith(fontSize: 14, color: AppColors.darkPink),
                    borderRadius: 34,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Divider(thickness: 2),
            const SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints(
                maxHeight: 400,
                minHeight: 200,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Row(
                        children: [
                          Text(
                            '${index + 1}',
                            style: sfProDisplaySemiBold.copyWith(
                              fontSize: 16,
                              color: AppColors.white.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(width: 18),
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: AppColors.yellowColor,
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: AppColors.grey300,
                              backgroundImage: AssetImage(AppImagePath.cardImage2),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('Savannah Nguyen'),
                                  const SizedBox(width: 16),
                                  SvgPicture.asset(
                                    AppImagePath.franceFlag,
                                    width: 24,
                                    height: 17,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Image.asset(AppImagePath.audienceBadge, width: 60, height: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
