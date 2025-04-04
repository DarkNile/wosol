import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/services/local/cache_helper.dart';

getLocationPermission(BuildContext context) {
  // if (false) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           backgroundColor: AppColors.white,
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //           child: SizedBox(
  //             height: Get.height * 0.5,
  //             child: Padding(
  //               padding: const EdgeInsets.all(6),
  //               child: Material(
  //                 color: AppColors.white,
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(16)),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(20.0),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Text("locationPermissionUserTitle".tr,
  //                           style: AppFonts.header),
  //                       const Expanded(child: SizedBox()),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           ElevatedButton(
  //                               style: ElevatedButton.styleFrom(
  //                                   backgroundColor: AppColors.white),
  //                               onPressed: () async {
  //                                 await CacheHelper.setData(
  //                                     key: 'isFirst', value: false);
  //                                 AppConstants.isFirst =
  //                                     await CacheHelper.getData(
  //                                             key: 'isFirst') ??
  //                                         true;
  //                                 log("isFirst ${AppConstants.isFirst}");
  //                                 Get.back();
  //                               },
  //                               child: Text(
  //                                 'Deny'.tr,
  //                                 style: AppFonts.button
  //                                     .copyWith(color: AppColors.error600),
  //                               )),
  //                           const SizedBox(
  //                             width: 24,
  //                           ),
  //                           ElevatedButton(
  //                               onPressed: () async {
  //                                 PermissionStatus status =
  //                                     await Permission.location.request();

  //                                 await CacheHelper.setData(
  //                                     key: 'isFirst', value: false);
  //                                 AppConstants.isFirst =
  //                                     await CacheHelper.getData(
  //                                             key: 'isFirst') ??
  //                                         true;
  //                                 log("isFirst ${AppConstants.isFirst}");
  //                                 if (status.isGranted) {
  //                                   log('status.isGranted');
  //                                   // Location permission is granted.
  //                                   // Proceed with location-based operations.
  //                                   Get.back();
  //                                 } else if (status.isDenied) {
  //                                   log('status.isDenied');
  //                                   // Location permission is denied.
  //                                   // Handle the scenario where the user denies permission.
  //                                   Get.back();
  //                                 } else if (status.isPermanentlyDenied) {
  //                                   log('status.isPermanentlyDenied');
  //                                   // Location permission is permanently denied.
  //                                   // Prompt the user to open app settings and enable permission.
  //                                   Get.back();
  //                                 }
  //                               },
  //                               style: ElevatedButton.styleFrom(
  //                                   backgroundColor: AppColors.white),
  //                               child: Text(
  //                                 'Accept'.tr,
  //                                 style: AppFonts.button
  //                                     .copyWith(color: AppColors.success600),
  //                               )),
  //                         ],
  //                       ),
  //                       const SizedBox(
  //                         height: 24,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // } else {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            height: 250,
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
                      Text(AppConstants.isEnLocale?
                      'Location Service is used to spot the students’ pick up points by the bus driver to reach their destinations.'
                          : 'يتم استخدام خدمة الموقع لتحديد نقاط الالتقاء للطلاب من قبل سائق الحافلة للوصول إلى وجهاتهم.',
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
                                    await CacheHelper.getData(key: 'isFirst') ??
                                        true;
                                log("isFirst ${AppConstants.isFirst}");
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
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
                                    await CacheHelper.getData(key: 'isFirst') ??
                                        true;
                                log("isFirst ${AppConstants.isFirst}");
                                if (status.isGranted) {
                                  log('status.isGranted');
                                  // Location permission is granted.
                                  // Proceed with location-based operations.
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                } else if (status.isDenied) {
                                  log('status.isDenied');
                                  // Location permission is denied.
                                  // Handle the scenario where the user denies permission.
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                } else if (status.isPermanentlyDenied) {
                                  log('status.isPermanentlyDenied');
                                  // Location permission is permanently denied.
                                  // Prompt the user to open app settings and enable permission.
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
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
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
//  }
}
