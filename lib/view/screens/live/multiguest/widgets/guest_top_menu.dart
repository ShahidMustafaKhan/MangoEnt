import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/widgets/privacy_sheet.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/widgets/tags_sheet.dart';
import 'package:teego/view/widgets/app_text_field.dart';
import 'package:teego/view_model/live_controller.dart';

class GuestTopMenu extends StatefulWidget {
  const GuestTopMenu({Key? key}) : super(key: key);

  @override
  State<GuestTopMenu> createState() => _GuestTopMenuState();
}

class _GuestTopMenuState extends State<GuestTopMenu> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.black.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImagePath.singleLiveBgImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: AppColors.black.withOpacity(0.4),
                        ),
                        child: Center(
                          child: Text(
                            'Peyton890@',
                            style: sfProDisplayRegular.copyWith(fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        child: AppTextFormField(
                          controller: _titleController,
                          validator: (value) {},
                          hintText: 'Add a title to chat',
                          hintStyle: sfProDisplayRegular.copyWith(
                            fontSize: 18,
                            color: AppColors.white,
                          ),
                          borderRadius: 0,
                          fillColor: AppColors.black.withOpacity(0.0),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                backgroundColor: AppColors.grey500,
                                builder: (context) => PrivacySheet(),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.grey300.withOpacity(0.6),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.groups, size: 18, color: AppColors.white),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Public',
                                    style: sfProDisplayRegular.copyWith(
                                      fontSize: 12,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.white),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.grey300.withOpacity(0.6),
                            child: Image.asset(AppImagePath.cameraOff, width: 13, height: 13),
                          ),
                          Spacer(),
                          Text(
                            'Select tag',
                            style: sfProDisplayRegular.copyWith(
                              fontSize: 12,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: (){
                              // showModalBottomSheet(
                              //   context: context,
                              //   shape: const RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.only(
                              //       topLeft: Radius.circular(20),
                              //       topRight: Radius.circular(20),
                              //     ),
                              //   ),
                              //   backgroundColor: AppColors.grey500,
                              //   builder: (context) => const TagsSheet(),
                              // );
                            },
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: AppColors.grey300.withOpacity(0.6),
                              child: Icon(Icons.keyboard_arrow_down_rounded, size: 13, color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: AppColors.grey300),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Share to',
                  style: sfProDisplayRegular.copyWith(
                    fontSize: 13,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                  child: Image.asset(AppImagePath.instagram, height: 16, width: 16),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                  child: Image.asset(AppImagePath.facebook, height: 16, width: 16),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                  child: Image.asset(AppImagePath.whatsapp, height: 16, width: 16),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                  child: const Icon(Icons.more_horiz, color: Colors.white, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
