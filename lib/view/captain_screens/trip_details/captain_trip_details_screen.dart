import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wosol/models/trip_list_model.dart';
import 'package:wosol/shared/widgets/captain_widgets/user_list_widget.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_header.dart';
import 'package:wosol/shared/widgets/shared_widgets/tripDetailsCard.dart';


class CaptainTripDetailsScreen extends StatelessWidget {
  const CaptainTripDetailsScreen({super.key, required this.dateTime, required this.from, required this.to, required this.confirmedStudents, required this.canceledStudents});
  final String dateTime;
  final String from;
  final String to;
  final List<Student> canceledStudents;
  final List<Student> confirmedStudents;

  @override
  Widget build(BuildContext context) {
    print(confirmedStudents.length);
    print(canceledStudents.length);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderWithBackButton(
              header: "tripDetails".tr,
            ),
            Expanded(
              child: ListView(
                physics: const PageScrollPhysics(),
                children: [
                  TripDetailsCard(
                      date: dateTime,
                      fromCity:
                          from,
                      toCity:
                          to,
                      isCaptain: true),
                 if(confirmedStudents.isNotEmpty)
                 customDivider(),
                  if(confirmedStudents.isNotEmpty)
                  UserListWidget(hasSubTitle: false, students: confirmedStudents,),
                  if(canceledStudents.isNotEmpty)
                 customDivider(),
                  if(canceledStudents.isNotEmpty)
                  UserListWidget(isCanceled: true, hasSubTitle: false, students: canceledStudents,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customDivider() {
    return const SizedBox(
      height: 10,
    );
  }
}
