import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide FormData, Response, MultipartFile;
import 'package:image_picker/image_picker.dart';

import '../../../controllers/shared_controllers/profile_controller.dart';
import '../../constants/constants.dart';
import '../../services/local/cache_helper.dart';
import '../../services/network/dio_helper.dart';

class PersonalPicture extends StatefulWidget {
  const PersonalPicture({super.key, required this.profileController});
  final ProfileController profileController;

  @override
  State<PersonalPicture> createState() => _PersonalPictureState();
}

class _PersonalPictureState extends State<PersonalPicture> {
  final imagePicker = ImagePicker();
  RxBool isUpdatingProfile = false.obs;
  Future<void> pickImageFromGallery(BuildContext context) async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      uploadImage(File(pickedImage.path));
    }
  }

  void uploadImage(File selectedProfileImage) async {
    setState(() {
      isUpdatingProfile.value = true;
    });

    FormData formData = FormData();
    String fileName = selectedProfileImage.path.split('/').last;
    formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(selectedProfileImage.path,
          filename: fileName),
      if (!AppConstants.isCaptain)
        "user_id": AppConstants.userRepository.userData.userId,
      if (false) "driver_id": AppConstants.userRepository.driverData.driverId,
    });
    try {
      Response response = await DioHelper.postData(
        url: "student/update_image",
        data: {},
        dataObject: formData,
      );
      if (response.statusCode == 200) {
        AppConstants.userRepository.userData.userImage =
            response.data["data"]["file_name"];
        CacheHelper.setData(
            key: 'UserData',
            value: jsonEncode(AppConstants.userRepository.userData.toJson()));
      }
      widget.profileController.changeImage();
      setState(() {
        isUpdatingProfile.value = false;
      });
    } catch (e) {
      setState(() {
        isUpdatingProfile.value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!AppConstants.isCaptain) {
          pickImageFromGallery(context);
        }
      },
      child: isUpdatingProfile.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SizedBox(
                    width: 96,
                    height: 96,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        (false
                                    ? AppConstants
                                        .userRepository.driverData.userImage
                                    : AppConstants
                                        .userRepository.userData.userImage)
                                .isNotEmpty
                            ? (false
                                ? AppConstants
                                    .userRepository.driverData.userImage
                                : AppConstants
                                    .userRepository.userData.userImage)
                            : 'assets/icons/logo.svg',
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    "assets/icons/upload_image.svg",
                    height: 32,
                    width: 32,
                  ),
                ),
              ],
            ),
    );
  }
}
