import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/menu_item_widget.dart';

class NotificationMenuWidget extends StatefulWidget {
  final void Function(String)? onSelected;
  const NotificationMenuWidget({super.key, required this.onSelected});

  @override
  State<NotificationMenuWidget> createState() => _NotificationMenuWidgetState();
}

class _NotificationMenuWidgetState extends State<NotificationMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      onSelected: widget.onSelected,
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      shadowColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: AppConstants.edge(padding: const EdgeInsets.only(left: 0)),
        child: SvgPicture.asset(
            width: 24, height: 24, 'assets/icons/list_mobile.svg'),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
            value: "MarkAsRead",
            height: 42,
            child: MenuItemWidget(
              svg: 'assets/icons/location-tick.svg',
              text: "MarkAsRead".tr,
            )),
        PopupMenuItem(
          height: 42,
          value: "Delete",
          child: MenuItemWidget(
            withBorder: false,
            svg: 'assets/icons/tick-square.svg',
            text: "Delete".tr,
          ),
        ),
      ],
    );
  }
}
