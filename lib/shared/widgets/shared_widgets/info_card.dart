import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wosol/controllers/shared_controllers/contact_data_controller.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: AppConstants.edge(
        padding: const EdgeInsets.only(
          top: 12,
          left: 10,
          right: 10,
        ),
      ),
      decoration: ShapeDecoration(
        color: AppColors.btnBackColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.logo),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/logo.svg",
            width: 64,
            height: 43,
          ),
          const SizedBox(height: 10),
          Text('For more edits you should Call Wosol'.tr,
              textAlign: TextAlign.center,
              style: AppFonts.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.black.withOpacity(.64))),
          const SizedBox(height: 10),
          GetBuilder<ContactDataController>(
            builder: (controller) => controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.contactDataModel == null
                    ? Text('No Data Received'.tr,
                        textAlign: TextAlign.center,
                        style: AppFonts.medium.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.black.withOpacity(.64)))
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/call.svg",
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                      controller
                                              .contactDataModel?.contactPhone ??
                                          "",
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.center,
                                      style: AppFonts.medium.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.logo)),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/email_icon.svg",
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                      controller
                                              .contactDataModel?.contactEmail ??
                                          "",
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.center,
                                      style: AppFonts.medium.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.logo)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
