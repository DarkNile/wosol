import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

// ignore: must_be_immutable
class CustomBottomSheetWidget extends StatelessWidget {
  final String headTitle;
  final Widget child;
  bool draggable;
  bool withCloseIcon;
  final double? height;
  CustomBottomSheetWidget({
    super.key,
    this.withCloseIcon = false,
    this.draggable = false,
    required this.headTitle,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // + 16 for padding
      height: (height != null) ? (height! + 26) : 294 + 26,
      padding: EdgeInsets.only(
        top: draggable ? 14 : 20,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x1E000000),
            blurRadius: 10,
            offset: Offset(0, -1),
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            draggable
                ? Center(
                    child: Container(
                      width: 56,
                      height: 5,
                      decoration: ShapeDecoration(
                        color: AppColors.darkBlue200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(headTitle, style: AppFonts.header),
                      if (withCloseIcon)
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: SvgPicture.asset('assets/icons/close.svg'))
                    ],
                  ),
            draggable ? const SizedBox(height: 14) : const SizedBox(height: 8),

            if (!draggable)
              const Divider(height: 1, color: AppColors.darkBlue100),
            child
          ]),
    );
  }
}
