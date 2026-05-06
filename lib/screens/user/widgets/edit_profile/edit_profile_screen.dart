import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neat_nest/controller/sign_in_controller.dart';
import 'package:neat_nest/screens/user/widgets/row_data_holder.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/image_upload_helper.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';
import 'package:neat_nest/widget/small_reusable_loader.dart';

import '../../../../data/storage/secure_storage_helper.dart';
import '../../../../widget/app_text.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? selectedImage;
  final SignInController signInController = SignInController();
  bool isLoading = false;
  String? userImageLink;

  @override
  void initState() {
    super.initState();
    loadUserImage();
  }

  void loadUserImage() async {
    final userData = await SecureStorageHelper.getUserData();

    if (userData != null && userData.profilePic != null) {
      setState(() {
        userImageLink = userData.profilePic;
      });
    }
  }

  Future<void> pickAndUploadImage() async {
    final file = await ImageUploadHelper.pickAndProcess(
      ImageSource.gallery,
      ImageType.profile,
    );

    if (file == null) return;

    setState(() {
      selectedImage = file;
      isLoading = true;
    });

    try {
      final updatedUser = await signInController.uploadProfilePic(file.path);

      if (updatedUser != null) {
        setState(() {
          userImageLink = updatedUser.profilePic;
          selectedImage = null;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        selectedImage = null;
        isLoading = false;
      });

      showErrorNotification(message: "Upload failed, try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Edit Profile'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.r),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child: selectedImage != null
                                  ? Opacity(
                                      opacity: 0.5,
                                      child: Image.file(
                                        selectedImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : (userImageLink != null &&
                                        userImageLink!.isNotEmpty)
                                  ? CachedNetworkImage(
                                      imageUrl: userImageLink!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          SmallLoader(),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                            Icons.person,
                                            size: 60,
                                            color: Colors.grey,
                                          ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                          10.ht,
                          primaryText(text: "Owovickky"),
                        ],
                      ),
                    ),

                    Positioned(
                      top: 35.h,
                      right: 90.w,
                      child: GestureDetector(
                        onTap: pickAndUploadImage,
                        child: Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: AppColors.primaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              20.ht,

              DottedLine(
                dashColor: AppColors.primaryColor.withValues(alpha: .5),
              ),

              10.ht,

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    RowDataHolder(
                      text: 'Personal Information',
                      icons: FontAwesomeIcons.user,
                      function: () {
                        AppNavigatorHelper.push(
                          context,
                          AppRoute.personalInfoEdit,
                        );
                      },
                    ),
                    15.ht,
                    RowDataHolder(
                      text: 'Payment Methods',
                      icons: FontAwesomeIcons.buildingColumns,
                      function: () {
                        AppNavigatorHelper.push(
                          context,
                          AppRoute.userPaymentMethod,
                        );
                      },
                    ),
                    15.ht,
                    RowDataHolder(
                      text: 'Address Information',
                      icons: FontAwesomeIcons.locationDot,
                      function: () {
                        AppNavigatorHelper.push(
                          context,
                          AppRoute.userAddresses,
                        );
                      },
                    ),
                    15.ht,
                    RowDataHolder(
                      text: 'About MySelf',
                      icons: FontAwesomeIcons.user,
                      function: () {
                        AppNavigatorHelper.push(
                          context,
                          AppRoute.viewAboutMeScreen,
                        );
                      },
                    ),
                    30.ht,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
