import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';
import 'package:wosol/shared/widgets/user_widgets/captain_number.dart';

import '../../constants/constants.dart';
import '../../constants/style/colors.dart';
import '../../constants/style/fonts.dart';
import '../captain_widgets/custom_captain_list_tile.dart';
import '../user_widgets/rating_bar_widget.dart';
import '../user_widgets/user_trip_detail_widget.dart';
import 'buttons.dart';
import 'custom_bottom_sheet_widget.dart';
import 'custom_check_tile.dart';
import 'custom_from_to_widget.dart';
import 'custom_status_widget.dart';
import 'optional_message_field.dart';
import 'or_widget.dart';

String _firstButtonText = "Start Ride".tr;
String _secondButtonText = "cancel".tr;

class BottomSheetBase extends StatelessWidget {
  const BottomSheetBase({
    super.key,
    required this.headTitle,
    required this.child,
    this.firstButtonText = 'Start Ride',
    this.secondButtonText = 'cancel',
    this.thirdButtonText = 'Turn Off this week only',
    this.firstButtonFunction,
    this.secondButtonFunction,
    this.thirdButtonFunction,
    this.svgFirstIconPath,
    this.svgSecondIconPath,
    this.height,
    this.withCloseIcon = false,
    this.draggable = false,
    this.containTwoButtons = false,
    this.buttonsContainIcon = false,
    this.showOrButton = false,
    this.showButtons = true,
    this.secondButtonTextColor,
    this.padding = const EdgeInsets.only(top: 30, bottom: 16),
    this.spaceBeforeButtons = 30,
    this.firstButtonsFlex = 5,
    this.secondButtonsFlex = 3,
    this.firstButtonColor,
    this.firstButtonMainAxisAlignment = MainAxisAlignment.center,
    this.firstTextColor,
    this.firstButtonLoading = false,
    this.secondButtonLoading = false,
    this.thirdButtonLoading = false,
  });

  final String headTitle;
  final Color? firstTextColor;
  final String? svgFirstIconPath;
  final String? svgSecondIconPath;
  final String firstButtonText;
  final String secondButtonText;
  final String thirdButtonText;
  final Widget child;
  final bool draggable;
  final bool withCloseIcon;
  final bool containTwoButtons;
  final bool buttonsContainIcon;
  final bool showButtons;
  final bool showOrButton;
  final bool firstButtonLoading;
  final bool secondButtonLoading;
  final bool thirdButtonLoading;
  final double? height;
  final double spaceBeforeButtons;
  final int firstButtonsFlex;
  final int secondButtonsFlex;
  final Color? secondButtonTextColor;
  final Color? firstButtonColor;
  final EdgeInsets padding;
  final Function()? firstButtonFunction;
  final Function()? secondButtonFunction;
  final Function()? thirdButtonFunction;
  final MainAxisAlignment firstButtonMainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetWidget(
      headTitle: headTitle,
      height: height,
      draggable: draggable,
      withCloseIcon: withCloseIcon,
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Expanded(child: child),
            if (showButtons)
              SizedBox(
                height: spaceBeforeButtons,
              ),
            if (showButtons)
              Row(
                children: [
                  Expanded(
                    flex: firstButtonsFlex,
                    child: DefaultRowButton(
                      loading: firstButtonLoading,
                      function: firstButtonFunction ?? () {},
                      containIcon: buttonsContainIcon,
                      text: firstButtonText,
                      textColor: firstTextColor ?? AppColors.white,
                      mainAxisAlignment: firstButtonMainAxisAlignment,
                      color: firstButtonColor ?? AppColors.logo,
                      svgPic: svgFirstIconPath ?? 'assets/images/tick.svg',
                    ),
                  ),
                  if (containTwoButtons)
                    const SizedBox(
                      width: 10,
                    ),
                  if (containTwoButtons)
                    Expanded(
                      flex: secondButtonsFlex,
                      child: DefaultRowButton(
                        loading: secondButtonLoading,
                        function: secondButtonFunction ?? () {},
                        containIcon: buttonsContainIcon,
                        svgPic: svgSecondIconPath ?? 'assets/images/close.svg',
                        text: secondButtonText,
                        textColor: secondButtonTextColor ?? AppColors.error600,
                        color: Colors.transparent,
                        border: Border.all(color: Colors.transparent),
                      ),
                    ),
                ],
              ),
            if (showOrButton)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: OrWidget(),
              ),
            if (showOrButton)
              DefaultRowButton(
                loading: thirdButtonLoading,
                function: thirdButtonFunction ?? () {},
                text: thirdButtonText,
              ),
          ],
        ),
      ),
    );
  }
}

class RideStartBottomSheet extends StatelessWidget {
  final String headTitle;
  final String? toTitle;
  final String? fromTitle;
  final String? date;
  final String? formTime;
  final String? toTime;
  final String? formPlace;
  final String? toPlace;
  final String? firstButtonText;
  final String? secondButtonText;
  final String? companyName;
  final String? companyTelephone;
  final String? companyEmail;
  final Function() firstButtonFunction;
  final Function()? secondButtonFunction;
  final bool fromUser;
  final bool isLoading;
  final String? tripId;

  const RideStartBottomSheet({
    super.key,
    required this.firstButtonFunction,
    this.firstButtonText,
    this.secondButtonFunction,
    required this.headTitle,
    this.formTime,
    this.toTime,
    this.formPlace,
    this.toPlace,
    this.fromUser = false,
    this.isLoading = false,
    this.toTitle,
    this.fromTitle,
    this.date,
    this.secondButtonText,
    this.companyName,
    this.companyTelephone,
    this.companyEmail,
    this.tripId,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      headTitle: headTitle,
      buttonsContainIcon: fromUser,
      showButtons: true,
      containTwoButtons: fromUser,
      firstButtonText:
          firstButtonText ?? (fromUser ? "I’m Ready".tr : "Start Ride".tr),
      secondButtonText: secondButtonText ?? 'Cancel Ride'.tr,
      firstButtonFunction: firstButtonFunction,
      secondButtonFunction: secondButtonFunction ?? () {},
      withCloseIcon: true,
      height: fromUser
          ? 301
          : companyName != null
              ? 370
              : null,
      firstButtonLoading: isLoading,
      child: fromUser
          ? UserTripDetailWidget(
              tripId: tripId!,
              fromTime: formTime!,
              toTime: toTime!,
              fromLocation: formPlace!,
              toLocation: toPlace!,
              fromTitle: fromTitle!,
              toTitle: toTitle!,
              date: date!,
            )
          : CustomFromToWidget(
              formTime: formTime!,
              toTime: toTime!,
              formPlace: formPlace!,
              toPlace: toPlace!,
              companyName: companyName,
              companyTelephone: companyTelephone,
              companyEmail: companyEmail,
              tripId: tripId,
            ),
    );
  }
}

class UpcomingRideBottomSheet extends StatelessWidget {
  final String headTitle;
  final String formTime;
  final String toTime;
  final String formPlace;
  final String toPlace;

  const UpcomingRideBottomSheet(
      {super.key,
      required this.headTitle,
      required this.formTime,
      required this.toTime,
      required this.formPlace,
      required this.toPlace});

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      headTitle: headTitle,
      buttonsContainIcon: false,
      showButtons: false,
      withCloseIcon: true,
      height: 220,
      child: CustomFromToWidget(
        formTime: formTime,
        toTime: toTime,
        formPlace: formPlace,
        toPlace: toPlace,
      ),
    );
  }
}

class ConfirmPickupBottomSheet extends StatelessWidget {
  const ConfirmPickupBottomSheet({
    super.key,
    required this.title,
    required this.subTitle,
    required this.firstButtonFunction,
    required this.secondButtonFunction,
  });

  final String title;
  final String subTitle;
  final Function() firstButtonFunction;
  final Function() secondButtonFunction;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      headTitle: '',
      draggable: true,
      secondButtonText: _secondButtonText,
      buttonsContainIcon: true,
      containTwoButtons: true,
      firstButtonText: "Confirm Pickup".tr,
      padding: AppConstants.edge(
          padding: const EdgeInsets.only(top: 24, bottom: 30)),
      spaceBeforeButtons: 24,
      height: 210,
      firstButtonFunction: firstButtonFunction,
      secondButtonFunction: secondButtonFunction,
      child: CustomCaptainListTileWidget(
        title: title,
        subTitle: subTitle,
        isCheckbox: false,
      ),
    );
  }
}

class CancellationReasonAndReportRideBottomSheet extends StatelessWidget {
  final String headTitle;
  final List<String> reasons;
  final int reasonsSelectedIndex;
  final Function() function;
  final TextEditingController? controller;
  final bool containTextField;

  const CancellationReasonAndReportRideBottomSheet({
    super.key,
    required this.function,
    required this.headTitle,
    required this.reasons,
    required this.reasonsSelectedIndex,
    this.containTextField = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      headTitle: headTitle,
      buttonsContainIcon: false,
      firstButtonFunction: function,
      withCloseIcon: true,
      firstButtonText: containTextField ? 'Send'.tr : 'Confirm'.tr,
      height: containTextField ? 570 : 415,
      child: SingleChildScrollView(
        physics: const PageScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              reasons.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                    bottom: index != reasons.length - 1 ? 12 : 0),
                child: CustomCheckTileWidget(
                  onTap: function,
                  title: reasons[index],
                  isChecked: reasonsSelectedIndex == index,
                ),
              ),
            ),
            if (containTextField)
              const SizedBox(
                height: 24,
              ),
            if (containTextField)
              OptionalMessage(
                controller: controller ?? TextEditingController(),
              ),
          ],
        ),
      ),
    );
  }
}

class SelectUsersToPickupBottomSheet extends StatelessWidget {
  final String headTitle;
  final Function() function;
  final List<String> titles;
  final List<String> subTitles;

  const SelectUsersToPickupBottomSheet({
    super.key,
    required this.function,
    required this.headTitle,
    required this.titles,
    required this.subTitles,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      headTitle: headTitle,
      buttonsContainIcon: false,
      firstButtonText: 'Confirm'.tr,
      firstButtonFunction: function,
      height: 317,
      child: SingleChildScrollView(
        physics: const PageScrollPhysics(),
        child: Column(
          children: List.generate(
            titles.length,
            (index) => Padding(
              padding:
                  EdgeInsets.only(bottom: index != titles.length - 1 ? 32 : 0),
              child: CustomCaptainListTileWidget(
                title: titles[index],
                subTitle: subTitles[index],
                isChat: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RideAndTripEndBottomSheet extends StatelessWidget {
  final String headTitle;
  final String imagePath;
  final String? lottiePath;
  final String headerMsg;
  final String subHeaderMsg;
  final bool isTrip;
  final bool containLottie;
  final Function()? function;

  const RideAndTripEndBottomSheet({
    super.key,
    required this.headTitle,
    required this.imagePath,
    required this.headerMsg,
    required this.subHeaderMsg,
    this.isTrip = false,
    this.function,
    this.containLottie = false,
    this.lottiePath,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      headTitle: headTitle,
      draggable: isTrip,
      showButtons: true,
      withCloseIcon: !isTrip,
      firstButtonText: 'Done',
      buttonsContainIcon: isTrip,
      svgFirstIconPath: 'assets/images/tick-circle.svg',
      firstButtonColor: AppColors.black,
      firstButtonFunction: function ?? () {},
      secondButtonFunction: () {},
      firstButtonsFlex: 1,
      height: isTrip ? 311 : 256,
      child: Center(
        child: CustomStatusWidget(
          imagePath: imagePath,
          title: headerMsg,
          subTitle: subHeaderMsg,
          containLottie: containLottie,
          lottiePath: lottiePath,
        ),
      ),
    );
  }
}

class TripCompletedBottomSheet extends StatelessWidget {
  final String imagePath;
  final String headerMsg;
  final Function() function;

  const TripCompletedBottomSheet({
    super.key,
    required this.imagePath,
    required this.headerMsg,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      headTitle: '',
      draggable: true,
      showButtons: true,
      firstButtonMainAxisAlignment: MainAxisAlignment.spaceBetween,
      padding:
          AppConstants.edge(padding: const EdgeInsets.only(top: 5, bottom: 25)),
      spaceBeforeButtons: 25,
      firstButtonText: 'Swap to End Trip',
      buttonsContainIcon: true,
      svgFirstIconPath: 'assets/images/arrow-right.svg',
      firstButtonFunction: function,
      height: 251,
      child: Center(
        child: CustomStatusWidget(
          imagePath: imagePath,
          title: headerMsg,
          subTitle: '',
        ),
      ),
    );
  }
}

class RideCanceledAndReportedBottomSheet extends StatelessWidget {
  final String headTitle;
  final String imagePath;
  final String headerMsg;
  final String subHeaderMsg;
  final bool isCancelFirstStep;
  final bool isReportFirstStep;
  final bool showOrButton;
  final bool firstButtonLoading;
  final bool secondButtonLoading;
  final bool thirdButtonLoading;
  final bool isCancel;

  final Function()? firstButtonFunction;
  final Function()? secondButtonFunction;
  final Function()? thirdButtonFunction;

  const RideCanceledAndReportedBottomSheet({
    super.key,
    required this.headTitle,
    required this.imagePath,
    required this.headerMsg,
    required this.subHeaderMsg,
    this.isCancelFirstStep = false,
    this.isReportFirstStep = false,
    this.showOrButton = false,
    this.firstButtonFunction,
    this.secondButtonFunction,
    this.thirdButtonFunction,
    this.firstButtonLoading = false,
    this.secondButtonLoading = false,
    this.thirdButtonLoading = false,
    this.isCancel = true,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      headTitle: headTitle,
      showButtons: isCancelFirstStep,
      containTwoButtons: true,
      firstButtonText: showOrButton
          ? (isCancel ? 'Turn off'.tr : 'Turn on'.tr)
          : isCancel
              ? 'Yes, Cancel ride'.tr
              : 'Un Cancel Ride'.tr,
      secondButtonText: isCancel ? 'No, Keep ride'.tr : 'No, Keep'.tr,
      thirdButtonText: isCancel ? 'turnOffThisWeek'.tr : "turnOnThisWeek".tr,
      firstButtonsFlex: 1,
      secondButtonsFlex: 1,
      withCloseIcon: true,
      showOrButton: showOrButton,
      secondButtonTextColor: AppColors.blueGray,
      firstButtonColor: showOrButton
          ? (isCancel ? AppColors.error600 : AppColors.success600)
          : AppColors.logo,
      svgFirstIconPath: 'assets/images/tick-circle.svg',
      firstButtonLoading: firstButtonLoading,
      firstButtonFunction: firstButtonFunction ?? () {},
      secondButtonLoading: secondButtonLoading,
      thirdButtonLoading: thirdButtonLoading,
      secondButtonFunction: secondButtonFunction ?? () {},
      thirdButtonFunction: thirdButtonFunction ?? () {},
      height: showOrButton
          ? 460
          : (isCancelFirstStep
              ? 362 + 12
              : isReportFirstStep
                  ? 276 + 5
                  : 254),
      child: Center(
        child: CustomStatusWidget(
          imagePath: imagePath,
          title: headerMsg,
          subTitle: subHeaderMsg,
        ),
      ),
    );
  }
}

class RateBottomSheet extends StatelessWidget {
  final String headTitle;
  final bool selectIssue;
  final Function() function;
  final Function(double) onRatingUpdate;
  final List<String> issues = [
    'Aggressive Driving'.tr,
    'Car wasn’t clean'.tr,
    'Ride arrive late'.tr,
    'Driver behaviour'.tr,
    'Driver behaviour'.tr,
    'The driver wasn’t the same'.tr,
    'Wrong vehicle arrived'.tr,
  ];

  RateBottomSheet({
    super.key,
    required this.function,
    required this.onRatingUpdate,
    required this.headTitle,
    required this.selectIssue,
  });

  @override
  Widget build(BuildContext context) {
    // Todo : ME
    return BottomSheetBase(
      headTitle: headTitle,
      buttonsContainIcon: false,
      firstButtonFunction: function,
      firstButtonText: 'Submit'.tr,
      withCloseIcon: true,
      height: selectIssue
          ? 485 //485
          : 250,
      //243,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: selectIssue ? Alignment.topLeft : Alignment.center,
            child: RatingBarWidget(
              itemSize: !selectIssue ? 60 : null,
              onRatingUpdate: onRatingUpdate,
            ),
          ),
          if (selectIssue)
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              child: Text('Select Issue (select one or more)'.tr,
                  style: AppFonts.header),
            ),
          if (selectIssue)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                issues.length,
                (index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomCheckTileWidget(
                      onTap: function,
                      title: issues[index],
                      isChecked:
                          index == 0 || index == 1 || index == 6 ? true : false,
                      withCircularCheckBox: false,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DriverComingSheetWidget extends StatelessWidget {
  final bool isOnMyHisWidget;

  const DriverComingSheetWidget({super.key, this.isOnMyHisWidget = true});

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      headTitle: '',
      draggable: true,
      padding: const EdgeInsets.only(top: 0),
      buttonsContainIcon: true,
      svgFirstIconPath: 'assets/icons/flag.svg',
      firstButtonFunction: () {},
      firstTextColor: AppColors.error600,
      firstButtonColor: Colors.transparent,
      firstButtonText: 'reportAProblem'.tr,
      withCloseIcon: false,
      spaceBeforeButtons: 12,
      height: 352,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: isOnMyHisWidget
                  ? const _OnMyHisWidget()
                  : const _HeadingWidget()),
          Container(
            height: 1,
            color: AppColors.darkBlue100,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: CaptainNumberWidget(
              carNumber: 'ق ط ل 2 4 6',
              carType: 'White Toyota Hiace ',
            ),
          ),
          Container(
            height: 1,
            color: AppColors.darkBlue100,
          ),
          SizedBox(
            height: 74,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextField(
                        height: 42,
                        validate: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.orange300,
                          ),
                        ),
                        fillColor: AppColors.orange50,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        textEditingController: TextEditingController(),
                        onSubmit: (val) {},
                        label: '',
                        hint: 'message mohammed',
                        hintStyle: AppFonts.medium.copyWith(
                          color: AppColors.black300,
                          fontWeight: FontWeight.w500,
                        ),
                        expands: false),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SvgPicture.asset(
                    'assets/icons/call.svg',
                    width: 42,
                    height: 42,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: AppColors.darkBlue100,
          ),
        ],
      ),
    );
  }
}

class _OnMyHisWidget extends StatelessWidget {
  const _OnMyHisWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'Mohammed Aly',
                    style: AppFonts.medium
                        .copyWith(fontSize: 16, color: AppColors.black800)),
                TextSpan(
                    text: ' is on his way',
                    style: AppFonts.medium.copyWith(
                      fontSize: 14,
                      color: AppColors.black800,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
        ),
        Container(
          width: 54,
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.darkBlue100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('5',
                  textAlign: TextAlign.center,
                  style: AppFonts.header.copyWith(
                    fontSize: 22, //25
                  )),
              Text('min',
                  textAlign: TextAlign.center,
                  style: AppFonts.medium.copyWith(
                    fontSize: 12,
                  )),
            ],
          ),
        )
      ],
    );
  }
}

class _HeadingWidget extends StatelessWidget {
  const _HeadingWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Heading to',
              style: AppFonts.medium.copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.black800),
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              'King Abdelaziz university',
              style: AppFonts.button.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.black800),
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Text(
              'Your trip will arrive at',
              style: AppFonts.small.copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.darkBlue400),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              '04:05 pm',
              style: AppFonts.medium.copyWith(color: AppColors.darkBlue500Base),
            ),
          ],
        ),
      ],
    );
  }
}

class RandomSheet extends StatelessWidget {
  final String headTitle;
  final String subTitle;
  final double height;
  final bool withCloseIcon;
  final Function() function;

  const RandomSheet({
    super.key,
    required this.headTitle,
    required this.subTitle,
    required this.function,
    this.height = 250,
    this.withCloseIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      headTitle: headTitle,
      buttonsContainIcon: false,
      firstButtonText: 'Confirm'.tr,
      firstButtonFunction: function,
      withCloseIcon: withCloseIcon,
      height: height,
      //243,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 12),
            child: Text(subTitle, style: AppFonts.header),
          ),
        ],
      ),
    );
  }
}
