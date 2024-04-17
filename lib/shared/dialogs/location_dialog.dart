import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/services/local/cache_helper.dart';

getLocationPermission(BuildContext context) {
  if (AppConstants.isCaptain) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: AppColors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: SizedBox(
              height: Get.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Material(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("locationPermissionDriverTitle".tr,
                            style: AppFonts.header),
                        const Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white),
                                onPressed: () async {
                                  await CacheHelper.setData(
                                      key: 'isFirst', value: false);
                                  AppConstants.isFirst =
                                      await CacheHelper.getData(
                                              key: 'isFirst') ??
                                          true;
                                  log("isFirst ${AppConstants.isFirst}");
                                  Get.back();
                                },
                                child: Text(
                                  'Deny'.tr,
                                  style: AppFonts.button
                                      .copyWith(color: AppColors.error600),
                                )),
                            const SizedBox(
                              width: 24,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  PermissionStatus status =
                                      await Permission.location.request();

                                  await CacheHelper.setData(
                                      key: 'isFirst', value: false);
                                  AppConstants.isFirst =
                                      await CacheHelper.getData(
                                              key: 'isFirst') ??
                                          true;
                                  log("isFirst ${AppConstants.isFirst}");
                                  if (status.isGranted) {
                                    log('status.isGranted');
                                    // Location permission is granted.
                                    // Proceed with location-based operations.
                                    Get.back();
                                  } else if (status.isDenied) {
                                    log('status.isDenied');
                                    // Location permission is denied.
                                    // Handle the scenario where the user denies permission.
                                    Get.back();
                                  } else if (status.isPermanentlyDenied) {
                                    log('status.isPermanentlyDenied');
                                    // Location permission is permanently denied.
                                    // Prompt the user to open app settings and enable permission.
                                    Get.back();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white),
                                child: Text(
                                  'Accept'.tr,
                                  style: AppFonts.button
                                      .copyWith(color: AppColors.success600),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: AppColors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: SizedBox(
              height: Get.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Material(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("locationPermissionUserTitle".tr,
                            style: AppFonts.header),
                        const Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white),
                                onPressed: () async {
                                  await CacheHelper.setData(
                                      key: 'isFirst', value: false);
                                  AppConstants.isFirst =
                                      await CacheHelper.getData(
                                              key: 'isFirst') ??
                                          true;
                                  log("isFirst ${AppConstants.isFirst}");
                                  Get.back();
                                },
                                child: Text(
                                  'Deny'.tr,
                                  style: AppFonts.button
                                      .copyWith(color: AppColors.error600),
                                )),
                            const SizedBox(
                              width: 24,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  PermissionStatus status =
                                      await Permission.location.request();

                                  await CacheHelper.setData(
                                      key: 'isFirst', value: false);
                                  AppConstants.isFirst =
                                      await CacheHelper.getData(
                                              key: 'isFirst') ??
                                          true;
                                  log("isFirst ${AppConstants.isFirst}");
                                  if (status.isGranted) {
                                    log('status.isGranted');
                                    // Location permission is granted.
                                    // Proceed with location-based operations.
                                    Get.back();
                                  } else if (status.isDenied) {
                                    log('status.isDenied');
                                    // Location permission is denied.
                                    // Handle the scenario where the user denies permission.
                                    Get.back();
                                  } else if (status.isPermanentlyDenied) {
                                    log('status.isPermanentlyDenied');
                                    // Location permission is permanently denied.
                                    // Prompt the user to open app settings and enable permission.
                                    Get.back();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white),
                                child: Text(
                                  'Accept'.tr,
                                  style: AppFonts.button
                                      .copyWith(color: AppColors.success600),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
