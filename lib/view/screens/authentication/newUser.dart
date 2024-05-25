import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/permission/choose_photo_permission.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/appButton.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view/widgets/country_list.dart';
import 'package:teego/view/widgets/validation_checker.dart';

import '../../../helpers/quick_help.dart';
import '../../../model/gender_model.dart';
import '../../../parse/UserModel.dart';
import '../../../utils/routes/app_routes.dart';
import '../../../view_model/userViewModel.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/select_country.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final GenderSelectionController genderController =
      Get.put(GenderSelectionController());
  final UserViewModel userViewModel = Get.find();
  var selectedGender = Gender.male.obs;

  void updateSelectedGender(Gender gender) {
    selectedGender.value = gender;
  }

  TextEditingController name = TextEditingController();
  TextEditingController homeTown = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Add form key
  RxBool isFormDirty = false.obs;

  late UserModel currentUser;
  String? userAvatar;
  String? userCover;
  String? selectedCountry;

  TextStyle hintStyle= sfProDisplayMedium.copyWith(fontSize: 12.sp, color: Colors.white.withOpacity(0.3));

  _getUser() async {
    if (currentUser.getFirstName != null) {
      name.text = currentUser.getFullName!;
    }

    if (currentUser.getBirthday != null) {
      dateOfBirth.text =
          QuickHelp.getBirthdayFromDate(currentUser.getBirthday!);
    }

    setState(() {
      userAvatar = currentUser.getAvatar != null
          ? currentUser.getAvatar!.url!
          : "";
      userCover = currentUser.getCover != null
          ? currentUser.getCover!.url!
          : "";
    });
  }

  updateUserModel(UserViewModel controller){
    if(currentUser.getAvatar != null){
      currentUser=controller.currentUser;
      userAvatar=controller.currentUser.getAvatar!.url;}
  }


  @override
  void initState() {
    currentUser=userViewModel.currentUser;
    _getUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formStyle = sfProDisplayMedium.copyWith(color: Colors.white70, fontSize: 18);
    return BaseScaffold(
      padding: EdgeInsets.only(top: Dimension.borderRadius, left: Dimension.borderRadius, right: Dimension.borderRadius ),
      body: SingleChildScrollView(
        child: GetBuilder<UserViewModel>(
            init: userViewModel,
            builder: (controller) {
              updateUserModel(controller);
              return Column(
                children: [
                  Obx(() {
                    return Form(
                      key: _formKey, // Assign form key to the form
                      autovalidateMode: isFormDirty.value ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Create User',
                              style: sfProDisplayBold.copyWith(fontSize: 36),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          InkWell(
                            onTap: (){
                              PermissionHandler.checkPermission(true, context);
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.yellow,
                              radius: ScreenUtil().setWidth(35),
                              backgroundImage: userAvatar!.isNotEmpty ? NetworkImage(userAvatar!) : null,
                              child: Visibility(
                                visible: userAvatar!.isEmpty,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: ScreenUtil().setHeight(30),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(24),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildRadioButton(Gender.male, 'Male', context),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(25),
                                    ),
                                    _buildRadioButton(Gender.female, 'Female', context),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(25),
                                    ),
                                    _buildRadioButton(Gender.others, 'Others', context),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(24),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextFormField(
                                  controller: name,
                                  enableHeadingText: true,
                                  headingText: 'Name',
                                  hintStyle: hintStyle,
                                  txtColor: AppColors.yellow,
                                  textInputAction: TextInputAction.next,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  validator: (value){
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  hintText: "Enter your Name"),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              Text(
                                'Home Country',
                                style: formStyle,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(8),
                              ),
                              CountryPickerFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select your country';
                                  }
                                  return null;
                                },
                                selectedCountry: selectedCountry,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              AppTextFormField(
                                controller: homeTown,
                                enableHeadingText: true,
                                headingText: 'Home Town',
                                hintStyle: hintStyle,
                                isPrefixIcon: true,
                                autoValidateMode: AutovalidateMode.disabled,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Enter your home town';
                                  }
                                  return null;
                                },
                                hintText: "Enter your home town",
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              AppTextFormField(
                                  controller: dateOfBirth,
                                  enableHeadingText: true,
                                  headingText: 'Date of Birth',
                                  hintStyle: hintStyle,
                                  txtColor: AppColors.yellow,
                                  textInputAction: TextInputAction.done,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  validator: (value){
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your date of birth';
                                    } else {
                                      String? dobError = dateOfBirthValidator(value);
                                      if (dobError != null) {
                                        return dobError;
                                      }
                                    }
                                    return null;
                                  },
                                  hintText: "Enter your birthday (MM/DD/YYYY)"),
                              SizedBox(
                                height: ScreenUtil().setHeight(isFormDirty.value==true ? 28 : 40),
                              ),
                              AppButton(context, "Next", () {
                                if (_formKey.currentState!.validate()) {
                                  if(userAvatar!.isEmpty){
                                    QuickHelp.showAppNotificationAdvanced(title: "Please upload a profile picture", context: context);
                                  }
                                  else{
                                    String gender=genderController.selectedGender.value==Gender.male ? UserModel.keyGenderMale : genderController.selectedGender.value==Gender.female ? UserModel.keyGenderFemale : UserModel.keyGenderOther;
                                    userViewModel.updateUserDetails(name.text, gender, selectedCountry ?? "Pakistan", dateOfBirth.text, context)
                                        .then((value) => Get.toNamed(AppRoutes.languageScreen, arguments: {"currentUser" : currentUser}));
                                  }
                                } else {
                                  isFormDirty.value = true;
                                }
                              }),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              );
          }
        ),
      ),
    );
  }

  Widget _buildRadioButton(Gender value, String label, BuildContext context) {
    final selectedGender = genderController.selectedGender.value;

    return Row(
      children: [
        Radio(
          activeColor: AppColors.yellow,
          value: value,
          groupValue: selectedGender,
          onChanged: (selected) {
            genderController.updateSelectedGender(selected as Gender);
          },
        ),
        Text(label),
      ],
    );
  }
}
