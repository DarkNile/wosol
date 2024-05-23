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
import '../../models/trip_list_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/constants/style/colors.dart';
import '../../shared/widgets/shared_widgets/buttons.dart';
import '../../shared/widgets/shared_widgets/custom_bottom_sheet_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.students,
    this.tripDate,
  });
  final List<Student> students;
  final String? tripDate;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = Get.find();
  final HomeDriverController homeDriverController =
      Get.put(HomeDriverController());
  final UserHomeController userHomeController = Get.put(UserHomeController());
  @override
  void initState() {
    super.initState();
    KeepScreenOn.turnOn();
  }

  @override
  void dispose() {
    super.dispose();
    KeepScreenOn.turnOff();
    mapController.googleMapController.future.then((ctlrer) => ctlrer.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: AppConstants.isCaptain,
      onPopInvoked: (v) {
        if (AppConstants.isCaptain) {
          homeDriverController.getTrips(context);
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
                    mapController.googleMapController.complete(controller);
                  },
                ),
                if (AppConstants.isCaptain)
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 8),
                                  child: widget.students.isNotEmpty &&
                                          (widget.students.length - 1 >
                                              mapController
                                                  .currentStudentIndex.value)
                                      ? Text(
                                          "${"studentName".tr}: ${widget.students[mapController.currentStudentIndex.value].userFname} ${widget.students[mapController.currentStudentIndex.value].userLname}",
                                          style: AppFonts.medium,
                                        )
                                      : Container(),
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
                if (AppConstants.isCaptain && widget.students.isNotEmpty)
                  GetBuilder<UserHomeController>(
                    builder: (ctrl) => Align(
                      alignment: AppConstants.isEnLocale
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
                                    headTitle: 'students'.tr,
                                    withCloseIcon: true,
                                    child: ListView.separated(
                                      physics: const PageScrollPhysics(),
                                      padding: AppConstants.edge(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20)),
                                      itemBuilder: (context, index) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                    '${widget.students[index].userFname} ${widget.students[index].userLname}',
                                                    style: AppFonts.header,
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                            flex: 2,
                                            child: DefaultRowButton(
                                              text: widget.students[index]
                                                          .cancelRequest ==
                                                      '0'
                                                  ? "cancelTrip".tr
                                                  : "unCancelTrip".tr,
                                              height: 30,
                                              border: widget.students[index]
                                                          .cancelRequest ==
                                                      '0'
                                                  ? Border.all(
                                                      color: AppColors.error600,
                                                    )
                                                  : null,
                                              color: widget.students[index]
                                                          .cancelRequest ==
                                                      '0'
                                                  ? AppColors.white
                                                  : AppColors.error600,
                                              function: () async {
                                                if (widget.students[index]
                                                        .cancelRequest ==
                                                    '0') {
                                                  widget.students[index]
                                                      .cancelRequest = '1';
                                                  await userHomeController
                                                      .tripCancelByDateAPI(
                                                    context: context,
                                                    userId: widget
                                                        .students[index].userId,
                                                    date: widget.tripDate!,
                                                    cancel: '1',
                                                    cancelReason: 'سبب الالغاء',
                                                  );
                                                } else {
                                                  widget.students[index]
                                                      .cancelRequest = '0';
                                                  await userHomeController
                                                      .tripCancelByDateAPI(
                                                    context: context,
                                                    userId: widget
                                                        .students[index].userId,
                                                    date: widget.tripDate!,
                                                    cancel: '0',
                                                  );
                                                }
                                              },
                                              textColor: widget.students[index]
                                                          .cancelRequest ==
                                                      '0'
                                                  ? AppColors.error600
                                                  : AppColors.white,
                                              borderRadius: 8,
                                              svgPic: widget.students[index]
                                                          .cancelRequest ==
                                                      '0'
                                                  ? 'assets/icons/close_red.svg'
                                                  : 'assets/icons/close_white.svg',
                                            ),
                                          )
                                        ],
                                      ),
                                      separatorBuilder: (context, index) =>
                                          const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Divider(
                                            height: 1,
                                            color: AppColors.darkBlue100),
                                      ),
                                      itemCount: widget.students.length,
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
