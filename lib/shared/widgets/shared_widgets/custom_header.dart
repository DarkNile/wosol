import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.header,
    this.onPressed,
    this.hasIcon = true,
    this.height = 48,
    this.textAlignment,
    this.headerSize = 18,
    this.background,
    this.itemsColor,
    this.headerColor,
    this.elevation = 1,
    this.isHome = false,
    this.hasPadding = true,
    required this.svgIcon,
    required this.iconWidth,
    required this.iconHeight,
  });

  final double height;
  final double headerSize;
  final String header;
  final bool isHome;
  final void Function()? onPressed;
  final Color? background;
  final Color? itemsColor;
  final String svgIcon;
  final double iconWidth;
  final double iconHeight;
  final Color? headerColor;
  final bool hasPadding;
  final bool hasIcon;
  final double elevation;
  final Alignment? textAlignment;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(
            horizontal: hasPadding ? 16 : 0, vertical: hasPadding ? 10 : 0),
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isHome
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${"Welcome".tr},',
                              style: AppFonts.medium.copyWith(
                                fontSize: headerSize,
                                color: headerColor ?? AppColors.black800,
                                // (AppConstants.themeController.isDarkMode.value
                                //     ? AppColors.whiteColor
                                //     : AppColors.primaryColor),

                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: ' $header',
                              style: AppFonts.header.copyWith(
                                fontSize: headerSize,
                                color: headerColor ?? AppColors.black800,
                                // (AppConstants.themeController.isDarkMode.value
                                //     ? AppColors.whiteColor
                                //     : AppColors.primaryColor),

                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        'assets/images/welcome.png',
                        width: 18,
                        height: 26,
                      )
                    ],
                  )
                : Text(
                    header,
                    style: AppFonts.header.copyWith(
                      fontSize: headerSize,
                      color: headerColor ?? AppColors.black800,
                      // (AppConstants.themeController.isDarkMode.value
                      //     ? AppColors.whiteColor
                      //     : AppColors.primaryColor),

                      fontWeight: FontWeight.w600,
                    ),
                  ),
            isHome
                ? SvgPicture.asset(
                    'assets/icons/logo.svg',
                    width: 50,
                    height: 34,
                    fit: BoxFit.fill,
                    colorFilter: itemsColor == null
                        ? null
                        : ColorFilter.mode(
                            itemsColor ?? AppColors.black,
                            // (AppConstants.themeController.isDarkMode.value
                            //     ? AppColors.whiteColor
                            //     : AppColors.redItem),
                            BlendMode.srcIn),
                  )
                : (hasIcon)
                    ? InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: onPressed ??
                            () {
                              Navigator.pop(context);
                            },
                        child: SvgPicture.asset(
                          svgIcon,
                          width: iconWidth,
                          height: iconHeight,
                          fit: BoxFit.fill,
                          colorFilter: itemsColor == null
                              ? null
                              : ColorFilter.mode(
                                  itemsColor ?? AppColors.black,
                                  // (AppConstants.themeController.isDarkMode.value
                                  //     ? AppColors.whiteColor
                                  //     : AppColors.redItem),
                                  BlendMode.srcIn),
                        ),
                      )
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class CustomHeaderWithBackButton extends StatelessWidget {
  const CustomHeaderWithBackButton({
    super.key,
    required this.header,
    this.onBackPressed,
    this.height = 48,
    this.textAlignment,
    this.headerSize = 18,
    this.background,
    this.itemsColor,
    this.headerColor,
    this.elevation = 1,
    this.isTraddy = false,
    this.traddyFunction,
  });

  final double height;
  final double headerSize;
  final String header;
  final void Function()? onBackPressed;
  final Color? background;
  final Color? itemsColor;
  final Color? headerColor;
  final double elevation;
  final Alignment? textAlignment;
  final bool isTraddy;
  final Function()? traddyFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.dividerColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.darkBlue100,
            width: elevation,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: onBackPressed ??
                () {
                  Navigator.pop(context);
                },
            child: SvgPicture.asset(
              AppConstants.localizationController
                          .currentLocale()
                          .languageCode ==
                      'en'
                  ? 'assets/icons/arrow-left.svg'
                  : 'assets/icons/arrow-right.svg',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              colorFilter: itemsColor == null
                  ? null
                  : ColorFilter.mode(
                      itemsColor ?? AppColors.black,
                      // (AppConstants.themeController.isDarkMode.value
                      //     ? AppColors.whiteColor
                      //     : AppColors.redItem),
                      BlendMode.srcIn),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            header,
            style: AppFonts.header.copyWith(
              fontSize: headerSize,
              color: headerColor ?? AppColors.black800,
              // (AppConstants.themeController.isDarkMode.value
              //     ? AppColors.whiteColor
              //     : AppColors.primaryColor),

              fontWeight: FontWeight.w600,
            ),
          ),
          if(isTraddy)
            const Spacer(),
          if(isTraddy)
            IconButton(
              onPressed: traddyFunction,
              icon: const Icon(Icons.location_on_outlined),
            ),
        ],
      ),
    );
  }
}

class CustomHeaderWithOptionalWidget extends StatelessWidget {
  const CustomHeaderWithOptionalWidget({
    super.key,
    required this.screenTitle,
    this.suffixWidget,
    required this.isWithBackArrow,
  });

  final String screenTitle;
  final Widget? suffixWidget;
  final bool isWithBackArrow;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        height: 48,
        width: AppConstants.screenWidth(context),
        color: AppColors.white,
        child: Row(
          children: [
            if (isWithBackArrow)
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.black800,
                ),
              ),
            if (!isWithBackArrow)
              // const SizedBox(
              //   width: 16,
              // ),
              Text(
                screenTitle,
                style: AppFonts.header,
              ),
            if (suffixWidget != null) const Spacer(),
            if (suffixWidget != null) suffixWidget!,
          ],
        ),
      ),
    );
  }
}
