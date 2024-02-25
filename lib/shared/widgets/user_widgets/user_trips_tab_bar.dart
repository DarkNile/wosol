import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

class UserTripsTabBarWidget extends StatefulWidget {
  const UserTripsTabBarWidget({
    super.key,
    this.controller,
    this.onTap,
    required this.selectIndex,
    required this.availableDays,
  });
  final TabController? controller;
  final List<String> availableDays;

  final void Function(int)? onTap;
  final int selectIndex;

  @override
  State<UserTripsTabBarWidget> createState() => _UserTripsTabBarWidgetState();
}

class _UserTripsTabBarWidgetState extends State<UserTripsTabBarWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TabBar(
        onTap: widget.onTap,
        tabAlignment: TabAlignment.start,
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            return states.contains(MaterialState.focused)
                ? null
                : Colors.transparent;
          },
        ),
        splashBorderRadius: BorderRadius.circular(50),
        labelPadding: AppConstants.edge(
            padding: const EdgeInsets.only(left: 0, right: 10)),
        indicatorPadding: AppConstants.edge(
            padding: const EdgeInsets.only(left: 0, right: 10)),
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicator: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.transparent, width: 0.0)),
        ),
        controller: widget.controller ??
            TabController(
              vsync: this,
              length: widget.availableDays.length + 1,
            ),
        padding: AppConstants.edge(
            padding: const EdgeInsets.only(left: 0, right: 10)),
        tabs: List.generate(
            widget.availableDays.length + 1,
            (index) => _TabWidget(
                text: index == 0 ? 'all'.tr : widget.availableDays[index - 1],
                isSelected: widget.selectIndex == index)).toList());
  }
}

class _TabWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  const _TabWidget({required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 32,
      iconMargin:
          AppConstants.edge(padding: const EdgeInsets.only(left: 0, right: 10)),
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        constraints: const BoxConstraints(
          minWidth: 56,
        ),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.logo : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: isSelected ? null : Border.all(color: AppColors.logo)),
        child: Text(text,
            style: AppFonts.medium.copyWith(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected ? AppColors.white : AppColors.logo,
            )),
      ),
    );
  }
}
