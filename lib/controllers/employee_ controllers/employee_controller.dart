import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../models/groups_list_model.dart';
import '../../models/trip_list_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/shared_widgets/snakbar.dart';
import '../../view/shared_screens/map_screen.dart';

class EmployeeController extends GetxController {
  RxBool isGettingTrips = false.obs;

  List<Trip> employeeNextRide = [];

  Future<void> getTrips(BuildContext context) async {
    employeeNextRide = [];
    isGettingTrips.value = true;
    try {
      Response response = await AppConstants.employeeRepository
          .getTrips(AppConstants.userRepository.employeeData.driverId);
      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          employeeNextRide = tripFromJson(response.data);
          isGettingTrips.value = false;
        } else {
          if (context.mounted &&
              ((response.data['data'] is Map) &&
                  (response.data['data'] as Map).containsKey('error'))) {
            defaultErrorSnackBar(
              context: context,
              message: response.data['data']['error'] ?? "",
            );
          }
          isGettingTrips.value = false;
        }
      } else {
        if (context.mounted&&
            ((response.data['data'] is Map) &&
                (response.data['data'] as Map).containsKey('error'))) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['data']['error'],
          );
        }
        isGettingTrips.value = false;
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      isGettingTrips.value = false;
    }
    update();
  }

  List<Group> groups = [];
  RxBool isGettingGroups = false.obs;
  Future<void> getGroupsList(BuildContext context) async {
    try {
      isGettingGroups.value = true;
      await AppConstants.employeeRepository
          .getGroupsList(
        AppConstants.userRepository.employeeData.driverId,
      )
          .then((response) {
        isGettingGroups.value = false;
        groups = GroupsList.fromJson(response.data).data;
        update();
      });
    } catch (e) {
      isGettingGroups.value = false;
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
    isGettingGroups.value = false;
    update();
  }

  void requestRide({
    required String groupId,
    required String lat,
    required String lng,
    required String date,
  }) async {
    try {
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%');
      Response response = await AppConstants.employeeRepository.requestRide(
        employeeId: AppConstants.userRepository.employeeData.driverId,
        groupId: groupId,
        lat: lat,
        lng: lng,
        date: date,
      );
      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          Get.to(() => const MapScreen(
                students: [],
              ));
          //defaultSuccessSnackBar(context: Get.context!, message: response.data['data']['data']);
        } else if (response.data['status'] == 'error') {
          defaultErrorSnackBar(context: Get.context!, message: "No Trips".tr);
        }
      }
    } on DioException catch (e) {
      defaultErrorSnackBar(
        context: Get.context!,
        message: e.response!.data['data']['data'],
      );
    }
    update();
  }
}
