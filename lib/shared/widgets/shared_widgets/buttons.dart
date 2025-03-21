import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants.dart';
import '../../constants/style/colors.dart';
import '../../constants/style/fonts.dart';

class DefaultButton extends StatelessWidget {
  final Color color;
  final void Function()? function;

  final double height;
  final double width;
  final double borderRadius;
  final double marginTop;
  final double marginBottom;
  final double marginRight;
  final double marginLeft;
  final bool loading;
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color textColor;
  final Border? border;
  final TextStyle? textStyle;
  final Widget? textWidget;
  final List<BoxShadow>? boxShadow;
  const DefaultButton({
    Key? key,
    required this.function,
    this.color = AppColors.logo,
    this.textColor = AppColors.white,
    this.height = 53,
    this.width = double.infinity,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.text = 'Login',
    this.border,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16,
    this.borderRadius = 10,
    this.marginRight = 0,
    this.marginLeft = 0,
    this.loading = false,
    this.textWidget,
    this.boxShadow,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        margin: AppConstants.edge(
          padding: EdgeInsets.only(
            top: marginTop,
            bottom: marginBottom,
            right: marginRight,
            left: marginLeft,
          ),
        ),
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: color,
          border: border,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: loading
              ? SizedBox(
                  height: height - 16,
                  width: height - 16,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: textWidget ??
                      Text(
                        text,
                        style: textStyle ??
                            AppFonts.button.copyWith(
                              color: textColor,
                              fontWeight: fontWeight,
                              fontSize: fontSize,
                            ),
                        textAlign: TextAlign.center,
                      ),
                ),
        ),
      ),
    );
  }
}

class DefaultTextButton extends StatelessWidget {
  final Color textColor;
  final String text;
  final void Function() function;
  final Widget? textAsWidget;
  final TextStyle? textStyle;
  final FontWeight fontWeight;
  final double fontSize;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double marginBottom;
  final bool addUnderLine;
  const DefaultTextButton({
    Key? key,
    required this.function,
    required this.text,
    this.textColor = AppColors.logo,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 14,
    this.textStyle,
    this.textAsWidget,
    this.marginBottom = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginTop = 0,
    this.addUnderLine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.edge(
        padding: EdgeInsets.only(
          top: marginTop,
          bottom: marginBottom,
          right: marginRight,
          left: marginLeft,
        ),
      ),
      child: InkWell(
        onTap: function,
        focusColor: AppColors.logo.withOpacity(0.1),
        hoverColor: AppColors.logo.withOpacity(0.1),
        highlightColor: AppColors.logo.withOpacity(0.1),
        splashColor: AppColors.logo.withOpacity(0.1),
        child: textAsWidget ??
            Text(
              text,
              style: textStyle ??
                  AppFonts.button.copyWith(
                    color: textColor,
                    fontWeight: fontWeight,
                    fontSize: fontSize,
                    decoration: addUnderLine
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
            ),
      ),
    );
  }
}

class DefaultRowButton extends StatelessWidget {
  final Color color;
  final MainAxisAlignment mainAxisAlignment;
  final String? svgPic;
  final double? sizedBoxWidth;

  final void Function()? function;
  final double height;
  final double width;
  final double borderRadius;
  final double marginTop;
  final double marginBottom;
  final double marginRight;
  final double marginLeft;
  final bool loading;
  final bool containIcon;
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color textColor;
  final Border? border;
  final TextStyle? textStyle;
  final Widget? textWidget;
  final List<BoxShadow>? boxShadow;
  const DefaultRowButton({
    Key? key,
    required this.function,
    this.color = AppColors.logo,
    this.textColor = AppColors.white,
    this.height = 53,
    this.width = double.infinity,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.text = 'Cancel Trip',
    this.border,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16,
    this.borderRadius = 10,
    this.marginRight = 0,
    this.marginLeft = 0,
    this.loading = false,
    this.containIcon = false,
    this.textWidget,
    this.boxShadow,
    this.textStyle,
    this.svgPic,
    this.sizedBoxWidth = 8,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        margin: AppConstants.edge(
          padding: EdgeInsets.only(
            top: marginTop,
            bottom: marginBottom,
            right: marginRight,
            left: marginLeft,
          ),
        ),
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: color,
          border: border,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: loading
              ? SizedBox(
                  height: height - 16,
                  width: height - 16,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : mainAxisAlignment == MainAxisAlignment.spaceBetween
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: mainAxisAlignment,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: textWidget ??
                                Text(
                                  text,
                                  style: textStyle ??
                                      AppFonts.button.copyWith(
                                        color: textColor,
                                        fontWeight: fontWeight,
                                        fontSize: fontSize,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                          ),
                          if (containIcon) SvgPicture.asset(svgPic!),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: mainAxisAlignment,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (containIcon && AppConstants.isEnLocale)
                          SvgPicture.asset(svgPic!),
                        if (containIcon && AppConstants.isEnLocale)
                          SizedBox(
                            width: sizedBoxWidth,
                          ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: textWidget ??
                              Text(
                                text,
                                style: textStyle ??
                                    AppFonts.button.copyWith(
                                      color: textColor,
                                      fontWeight: fontWeight,
                                      fontSize: fontSize,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                        ),
                        if (containIcon && !AppConstants.isEnLocale)
                          SizedBox(
                            width: sizedBoxWidth,
                          ),
                        if (containIcon && !AppConstants.isEnLocale)
                          SvgPicture.asset(svgPic!),
                      ],
                    ),
        ),
      ),
    );
  }
}
