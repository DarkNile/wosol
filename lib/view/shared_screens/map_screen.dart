import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wosol/controllers/shared_controllers/map_controller.dart';
import 'package:wosol/controllers/user_controllers/user_home_controller.dart';
import 'package:wosol/shared/constants/style/fonts.dart';

import '../../controllers/captain_controllers/home_driver_controller.dart';
import '../../controllers/employee_ controllers/employee_controller.dart';
import '../../models/trip_list_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/constants/style/colors.dart';
import '../../shared/widgets/shared_widgets/bottom_sheets.dart';
import '../../shared/widgets/shared_widgets/buttons.dart';
import '../../shared/widgets/shared_widgets/custom_bottom_sheet_widget.dart';
import '../../shared/widgets/shared_widgets/custom_check_tile.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.students,
    this.tripId,
    this.isRound = false,
    this.isTraddy = false,
    this.isStudent = false,
  });

  final List<Student> students;
  final String? tripId;
  final bool isStudent;
  final bool isRound;
  final bool isTraddy;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = Get.find();
  final HomeDriverController homeDriverController =
      Get.put(HomeDriverController());
  final UserHomeController userHomeController = Get.put(UserHomeController());
  EmployeeController employeeController = Get.put(EmployeeController());

  @override
  void initState() {
    super.initState();
    if (AppConstants.userType == 'Driver') {
      mapController.getTripDetailsApi(tripId: widget.tripId!);
    }
    // if(widget.students.isNotEmpty){
    //   for (var student in widget.students) {
    //     if(student.attendance == '0'){
    //       mapController.leftStudents.add(student);
    //     } else if(student.attendance == '1'){
    //       mapController.confirmedStudents.add(student);
    //     } else{
    //       mapController.canceledStudents.add(student);
    //     }
    //   }
    // }
    print(mapController.confirmedStudents.length);
    print(mapController.leftStudents.length);
    print(mapController.canceledStudents.length);
    KeepScreenOn.turnOn();
  }

  @override
  void dispose() {
    super.dispose();
    mapController.googleMapController = Completer<GoogleMapController>();
    if (mapController.positionStream != null) {
      mapController.positionStream!.cancel();
      mapController.positionStream = null;
    }
    KeepScreenOn.turnOff();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: AppConstants.userType == 'Driver',
      onPopInvoked: (v) {
        if (AppConstants.userType == 'Driver') {
          homeDriverController.getTrips(context);
        } else if (AppConstants.userType == 'Student') {
          userHomeController.getTrips();
          userHomeController.getCalendarData();
        } else if (AppConstants.userType == 'Employee') {
          employeeController.getTrips(context);
        }
      },
      child: SafeArea(
        child: SizedBox(
          width: AppConstants.screenSize(context).width,
          height: AppConstants.screenSize(context).height,
          child: GetBuilder<MapController>(builder: (mapController) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                GoogleMap(
                  padding: const EdgeInsets.only(bottom: 100),
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  initialCameraPosition: mapController.cameraPosition,
                  gestureRecognizers: {
                    Factory<PanGestureRecognizer>(
                        () => PanGestureRecognizer(allowedButtonsFilter: (i) {
                              mapController.enableLocation.value = false;
                              return false;
                            })),
                    Factory<ScaleGestureRecognizer>(
                        () => ScaleGestureRecognizer(allowedButtonsFilter: (i) {
                              mapController.enableLocation.value = false;
                              return false;
                            })),
                  },
                  markers: {
                    // if(mapController.finalLatLng != null)
                    // Marker(
                    //   markerId: const MarkerId('final'),
                    //   position: mapController.finalLatLng!,
                    //   icon:
                    //   BitmapDescriptor.fromBytes(mapController.markerIcon),
                    // ),
                    if (mapController.startIcon != null)
                      Marker(
                        markerId: const MarkerId('start'),
                        position: mapController.startLatLng,
                        icon: BitmapDescriptor.fromBytes(
                            mapController.startIcon!),
                      ),
                    Marker(
                      markerId: const MarkerId('target'),
                      position: mapController.targetLatLng,
                      icon:
                          BitmapDescriptor.fromBytes(mapController.markerIcon),
                    ),
                    Marker(
                      markerId: const MarkerId('current'),
                      position: mapController.currentLatLng,
                      rotation: mapController.previousLatLng != null
                          ? mapController.calculateBearing(
                              mapController.previousLatLng!,
                              mapController.currentLatLng)
                          : 90,
                      icon:
                          BitmapDescriptor.fromBytes(mapController.currentIcon),
                      anchor: const Offset(0.5, 0.5),
                    )
                  },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('CT'),
                      points: mapController.polylineCurrentTarget,
                      color: AppColors.blue,
                    ),
                    // if(mapController.polylineCurrentFinal.isNotEmpty)
                    //   Polyline(
                    //     polylineId: const PolylineId('CF'),
                    //     points: mapController.polylineCurrentFinal,
                    //     color: AppColors.blue,
                    //   ),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    if (!mapController.googleMapController.isCompleted) {
                      mapController.googleMapController.complete(controller);
                    }
                  },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      padding: const EdgeInsets.only(top: 20),
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.black,
                      )),
                ),
                if (AppConstants.userType == 'Driver')
                  Obx(
                    () => Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (!mapController.enableLocation.value) {
                                      mapController.cameraToPosition(
                                          mapController.currentLatLng);
                                    }
                                    mapController.enableLocation.value =
                                        !mapController.enableLocation.value;
                                  },
                                  icon: Icon(
                                    Icons.my_location,
                                    size: 30,
                                    color: mapController.enableLocation.value
                                        ? AppColors.blue
                                        : Colors.grey,
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          if(AppConstants.userType == 'Driver') //&& widget.isStudent)
                            Material(
                              child: DefaultButton(
                                marginRight: 20,
                                marginLeft: 20,
                                height: 45,
                                function: () async{
                                  await mapController.tripEnd(tripId: widget.tripId!);
                                  mapController.distantTrack = "10000 km";
                                  if (mapController.positionStream != null) {
                                    mapController.positionStream!.cancel();
                                    mapController.positionStream = null;
                                  }

                                },
                                text: 'endTrip'.tr,),
                            ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (!widget.isTraddy)
                            Container(
                              height: 100,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 2),
                                      spreadRadius: 3,
                                      color: AppColors.black.withOpacity(0.10),
                                    ),
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GetBuilder<MapController>(
                                    builder: (context) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: mapController
                                                  .currentStudents.isNotEmpty &&
                                              mapController.currentStudentIndex
                                                      .value !=
                                                  -1 &&
                                              !widget.isRound
                                          ? Text(
                                              "${"studentName".tr}: ${mapController.currentStudents[0].userFname} ${mapController.currentStudents[0].userLname}",
                                              style: AppFonts.medium,
                                            )
                                          : Container(),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: AppColors.offWhite,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: AppColors.black)),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time_rounded,
                                              color: AppColors.black,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              mapController.timeTrack,
                                              style: AppFonts.header,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: AppColors.offWhite,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: AppColors.black)),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_rounded,
                                              color: AppColors.black,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              mapController.distantTrack,
                                              style: AppFonts.header,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                if (AppConstants.userType == 'Driver' &&
                    widget.students.isNotEmpty &&
                    !widget.isRound &&
                    !widget.isTraddy)
                  GetBuilder<UserHomeController>(
                    builder: (ctrl) => Align(
                      alignment: !AppConstants.isEnLocale
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: IconButton(
                          color: AppColors.black,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isDismissible: false,
                                enableDrag: false,
                                builder: (context) {
                                  return CustomBottomSheetWidget(
                                    height: Get.height * 0.7,
                                    headTitle: 'manageTrip'.tr,
                                    withCloseIcon: true,
                                    child: SingleChildScrollView(
                                      physics: const PageScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'confirmed'.tr,
                                            style: AppFonts.header,
                                          ),
                                          ListView.separated(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: AppConstants.edge(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 20)),
                                            itemBuilder: (context, index) =>
                                                Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.person,
                                                          color: AppColors.logo,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          '${mapController.confirmedStudents[index].userFname} ${mapController.confirmedStudents[index].userLname}',
                                                          style:
                                                              AppFonts.header,
                                                        ),
                                                      ],
                                                    )),
                                                // Expanded(
                                                //   flex: 2,
                                                //   child: DefaultRowButton(
                                                //     text: mapController.confirmedStudents[index]
                                                //                 .cancelRequest ==
                                                //             '0'
                                                //         ? "cancelTrip".tr
                                                //         : "unCancelTrip".tr,
                                                //     height: 30,
                                                //     border: mapController.confirmedStudents[index]
                                                //                 .cancelRequest ==
                                                //             '0'
                                                //         ? Border.all(
                                                //             color: AppColors.error600,
                                                //           )
                                                //         : null,
                                                //     color: mapController.confirmedStudents[index]
                                                //                 .cancelRequest ==
                                                //             '0'
                                                //         ? AppColors.white
                                                //         : AppColors.error600,
                                                //     function: () async {
                                                //       if (mapController.confirmedStudents[index]
                                                //               .cancelRequest ==
                                                //           '0') {
                                                //         mapController.confirmedStudents[index]
                                                //             .cancelRequest = '1';
                                                //         await userHomeController.tripCancelAPI(
                                                //           context: context,
                                                //           userId: widget
                                                //               .students[index].userId,
                                                //           cancel: '1',
                                                //           cancelReason: 'سبب الالغاء',
                                                //           tripUserId: widget
                                                //               .students[index].tripUserId,
                                                //           tripId: widget.tripId!,
                                                //         );
                                                //       } else {
                                                //         mapController.confirmedStudents[index]
                                                //             .cancelRequest = '0';
                                                //         await userHomeController.tripCancelAPI(
                                                //           context: context,
                                                //           userId: widget
                                                //               .students[index].userId,
                                                //           cancel: '0',
                                                //           tripUserId: widget
                                                //               .students[index].tripUserId,
                                                //           tripId: widget.tripId!,
                                                //         );
                                                //       }
                                                //     },
                                                //     textColor: mapController.confirmedStudents[index]
                                                //                 .cancelRequest ==
                                                //             '0'
                                                //         ? AppColors.error600
                                                //         : AppColors.white,
                                                //     borderRadius: 8,
                                                //     svgPic: mapController.confirmedStudents[index]
                                                //                 .cancelRequest ==
                                                //             '0'
                                                //         ? 'assets/icons/close_red.svg'
                                                //         : 'assets/icons/close_white.svg',
                                                //   ),
                                                // )
                                              ],
                                            ),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Divider(
                                                  height: 1,
                                                  color: AppColors.darkBlue100),
                                            ),
                                            itemCount: mapController
                                                .confirmedStudents.length,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Divider(
                                              height: 1,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          Text(
                                            'canceled'.tr,
                                            style: AppFonts.header,
                                          ),
                                          ListView.separated(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: AppConstants.edge(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 20)),
                                            itemBuilder: (context, index) =>
                                                Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.person,
                                                          color: AppColors.logo,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          '${mapController.canceledStudents[index].userFname} ${mapController.canceledStudents[index].userLname}',
                                                          style:
                                                              AppFonts.header,
                                                        ),
                                                      ],
                                                    )),
                                                Expanded(
                                                  flex: 2,
                                                  child: DefaultRowButton(
                                                    text: mapController
                                                                .canceledStudents[
                                                                    index]
                                                                .cancelRequest ==
                                                            '0'
                                                        ? "cancelTrip".tr
                                                        : "unCancelTrip".tr,
                                                    height: 30,
                                                    border: mapController
                                                                .canceledStudents[
                                                                    index]
                                                                .cancelRequest ==
                                                            '0'
                                                        ? Border.all(
                                                            color: AppColors
                                                                .error600,
                                                          )
                                                        : null,
                                                    color: mapController
                                                                .canceledStudents[
                                                                    index]
                                                                .cancelRequest ==
                                                            '0'
                                                        ? AppColors.white
                                                        : AppColors.error600,
                                                    function: () async {
                                                      if (mapController
                                                              .canceledStudents[
                                                                  index]
                                                              .cancelRequest ==
                                                          '0') {
                                                        userHomeController
                                                            .getCancelReasons()
                                                            .then((_) {
                                                          Get.back();
                                                          if (context.mounted) {
                                                            showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                isDismissible:
                                                                    false,
                                                                enableDrag:
                                                                    false,
                                                                builder:
                                                                    (context) =>
                                                                        BottomSheetBase(
                                                                          headTitle:
                                                                              'cancellationReason'.tr,
                                                                          buttonsContainIcon:
                                                                              false,
                                                                          withCloseIcon:
                                                                              true,
                                                                          showButtons:
                                                                              false,
                                                                          // height: 200,
                                                                          child:
                                                                              Obx(
                                                                            () => userHomeController.isGettingCancelReasons.value
                                                                                ? const Center(child: CircularProgressIndicator())
                                                                                : ListView.separated(
                                                                                    itemBuilder: (ctx, index) => CustomCheckTileWidget(
                                                                                      onTap: () async {
                                                                                        userHomeController.selectedReasons = userHomeController.cancelReasonsModel!.data[index];
                                                                                        // Get.back();
                                                                                        mapController.canceledStudents[index].cancelRequest = '1';
                                                                                        await userHomeController.tripCancelAPI(
                                                                                          context: context,
                                                                                          userId: mapController.canceledStudents[index].userId,
                                                                                          cancel: '1',
                                                                                          cancelReason: 'سبب الالغاء',
                                                                                          tripUserId: mapController.canceledStudents[index].tripUserId,
                                                                                          tripId: widget.tripId!,
                                                                                          student: mapController.canceledStudents[index],
                                                                                        );
                                                                                      },
                                                                                      title: AppConstants.isEnLocale ? userHomeController.cancelReasonsModel!.data[index].reasonEn! : userHomeController.cancelReasonsModel!.data[index].reasonAr!,
                                                                                      withCircularCheckBox: false,                                                                                    ),
                                                                                    separatorBuilder: (context, index) => const SizedBox(
                                                                                      height: 8,
                                                                                    ),
                                                                                    itemCount: userHomeController.cancelReasonsModel!.data.length,
                                                                                  ),
                                                                          ),
                                                                        ));
                                                          }
                                                        });
                                                      } else {
                                                        mapController
                                                            .canceledStudents[
                                                                index]
                                                            .cancelRequest = '0';
                                                        await userHomeController
                                                            .tripCancelAPI(
                                                          context: context,
                                                          userId: mapController
                                                              .canceledStudents[
                                                                  index]
                                                              .userId,
                                                          cancel: '0',
                                                          tripUserId: mapController
                                                              .canceledStudents[
                                                                  index]
                                                              .tripUserId,
                                                          tripId:
                                                              widget.tripId!,
                                                          student: mapController
                                                                  .canceledStudents[
                                                              index],
                                                        );
                                                      }
                                                    },
                                                    textColor: mapController
                                                                .canceledStudents[
                                                                    index]
                                                                .cancelRequest ==
                                                            '0'
                                                        ? AppColors.error600
                                                        : AppColors.white,
                                                    borderRadius: 8,
                                                    svgPic: mapController
                                                                .canceledStudents[
                                                                    index]
                                                                .cancelRequest ==
                                                            '0'
                                                        ? 'assets/icons/close_red.svg'
                                                        : 'assets/icons/close_white.svg',
                                                  ),
                                                )
                                              ],
                                            ),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Divider(
                                                  height: 1,
                                                  color: AppColors.darkBlue100),
                                            ),
                                            itemCount: mapController
                                                .canceledStudents.length,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Divider(
                                              height: 1,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          Text(
                                            'left'.tr,
                                            style: AppFonts.header,
                                          ),
                                          ListView.separated(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: AppConstants.edge(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 20)),
                                            itemBuilder: (context, index) =>
                                                Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.person,
                                                          color: AppColors.logo,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          '${mapController.leftStudents[index].userFname} ${mapController.leftStudents[index].userLname}',
                                                          style:
                                                              AppFonts.header,
                                                        ),
                                                      ],
                                                    )),
                                                Expanded(
                                                  flex: 2,
                                                  child: DefaultRowButton(
                                                    text: mapController
                                                                .leftStudents[
                                                                    index]
                                                                .cancelRequest ==
                                                            '0'
                                                        ? "cancelTrip".tr
                                                        : "unCancelTrip".tr,
                                                    height: 30,
                                                    border: mapController
                                                                .leftStudents[
                                                                    index]
                                                                .cancelRequest ==
                                                            '0'
                                                        ? Border.all(
                                                            color: AppColors
                                                                .error600,
                                                          )
                                                        : null,
                                                    color: mapController
                                                                .leftStudents[
                                                                    index]
                                                                .cancelRequest ==
                                                            '0'
                                                        ? AppColors.white
                                                        : AppColors.error600,
                                                    function: () async {
                                                      if (mapController
                                                              .leftStudents[
                                                                  index]
                                                              .cancelRequest ==
                                                          '0') {
                                                        userHomeController
                                                            .getCancelReasons()
                                                            .then((_) {
                                                          Get.back();
                                                          if (context.mounted) {
                                                            showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                isDismissible:
                                                                    false,
                                                                enableDrag:
                                                                    false,
                                                                builder:
                                                                    (context) =>
                                                                        BottomSheetBase(
                                                                          headTitle:
                                                                              'cancellationReason'.tr,
                                                                          buttonsContainIcon:
                                                                              false,
                                                                          withCloseIcon:
                                                                              true,
                                                                          showButtons:
                                                                              false,
                                                                          // height: 200,
                                                                          child:
                                                                              Obx(
                                                                            () => userHomeController.isGettingCancelReasons.value
                                                                                ? const Center(child: CircularProgressIndicator())
                                                                                : ListView.separated(
                                                                                    itemBuilder: (context, index) => CustomCheckTileWidget(
                                                                                      onTap: () async {
                                                                                        userHomeController.selectedReasons = userHomeController.cancelReasonsModel!.data[index];
                                                                                        // Get.back();
                                                                                        mapController.leftStudents[index].cancelRequest = '1';
                                                                                        await userHomeController.tripCancelAPI(
                                                                                          context: context,
                                                                                          userId: mapController.leftStudents[index].userId,
                                                                                          cancel: '1',
                                                                                          cancelReason: 'سبب الالغاء',
                                                                                          tripUserId: mapController.leftStudents[index].tripUserId,
                                                                                          tripId: widget.tripId!,
                                                                                          student: mapController.leftStudents[index],
                                                                                        );
                                                                                      },
                                                                                      title: AppConstants.isEnLocale ? userHomeController.cancelReasonsModel!.data[index].reasonEn! : userHomeController.cancelReasonsModel!.data[index].reasonAr!,
                                                                                      withCircularCheckBox: false,                                                                                    ),
                                                                                    separatorBuilder: (context, index) => const SizedBox(
                                                                                      height: 8,
                                                                                    ),
                                                                                    itemCount: userHomeController.cancelReasonsModel!.data.length,
                                                                                  ),
                                                                          ),
                                                                        ));
                                                          }
                                                        });
                                                      } else {
                                                        mapController
                                                            .leftStudents[index]
                                                            .cancelRequest = '0';
                                                        await userHomeController
                                                            .tripCancelAPI(
                                                          context: context,
                                                          userId: mapController
                                                              .leftStudents[
                                                                  index]
                                                              .userId,
                                                          cancel: '0',
                                                          tripUserId:
                                                              mapController
                                                                  .leftStudents[
                                                                      index]
                                                                  .tripUserId,
                                                          tripId:
                                                              widget.tripId!,
                                                          student: mapController
                                                                  .leftStudents[
                                                              index],
                                                        );
                                                      }
                                                    },
                                                    textColor: mapController
                                                                .leftStudents[
                                                                    index]
                                                                .cancelRequest ==
                                                            '0'
                                                        ? AppColors.error600
                                                        : AppColors.white,
                                                    borderRadius: 8,
                                                    svgPic: mapController
                                                                .leftStudents[
                                                                    index]
                                                                .cancelRequest ==
                                                            '0'
                                                        ? 'assets/icons/close_red.svg'
                                                        : 'assets/icons/close_white.svg',
                                                  ),
                                                )
                                              ],
                                            ),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Divider(
                                                  height: 1,
                                                  color: AppColors.darkBlue100),
                                            ),
                                            itemCount: mapController
                                                .leftStudents.length,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.menu_rounded,
                            size: 30,
                            color: mapController.enableLocation.value
                                ? AppColors.blue
                                : Colors.grey,
                          )),
                    ),
                  ),

              ],
            );
          }),
        ),
      ),
    );
  }
}
