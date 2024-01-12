import 'package:flutter/material.dart';

import '../../../../shared/widgets/shared_widgets/bottom_sheets.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RideStartBottomSheet(
                  firstButtonFunction: (){},
                  headTitle: 'Ride start within 59 sec',
                  formTime: '10:05 am',
                  toTime: '11:30 am',
                  formPlace: 'Mecca ',
                  toPlace: 'King Abdelaziz University ',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: UpcomingRideBottomSheet(
                    headTitle: 'Ride start within 59 sec',
                    formTime: '10:05 am',
                    toTime: '11:30 am',
                    formPlace: 'Mecca ',
                    toPlace: 'King Abdelaziz University ',
                  ),
                ),
                ConfirmPickupBottomSheet(
                  title: 'Air Port',
                  subTitle: 'Future st, building no 13',
                  firstButtonFunction: (){},
                  secondButtonFunction: (){},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CancelationReasonAndReportRideBottomSheet(
                    function: (){},
                    headTitle: 'Cancelation reason',
                    reasons: const ['No Show', 'User canceled the trip', 'Canceled by customer support', 'Other'],
                    reasonsSelectedIndex: 3,
                  ),
                ),
                SelectUsersToPickupBottomSheet(
                  function: (){},
                  headTitle: 'Select users to pickup',
                  titles: const ['Hossam', 'Mostafa Ahmed'],
                  subTitles: const ['Future st, building no 13', 'Future st, building no 13'],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: RideAndTripEndBottomSheet(
                    headTitle: 'Ride end',
                    lottiePath: 'assets/lottie/congratulation.json',
                    headerMsg: 'Congratulations ',
                    subHeaderMsg: 'ride completed successfully, Thank you',
                  ),
                ),
                RideAndTripEndBottomSheet(
                  function: (){},
                  headTitle: 'Ride end',
                  lottiePath: 'assets/lottie/congratulation.json',
                  headerMsg: 'Congratulations ',
                  subHeaderMsg: 'ride completed successfully, Thank you',
                  isTrip: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TripCompletedBottomSheet(
                    lottiePath: 'assets/lottie/congratulation.json',
                    headerMsg: 'Trip Completed?',
                    function: (){},
                  ),
                ),
                RideCanceledAndReportedBottomSheet(
                  headTitle: 'Cancel Ride',
                  lottiePath: 'assets/lottie/congratulation.json',
                  headerMsg: 'You are about to cancel your ride, are you sure?',
                  subHeaderMsg: 'Note: today trip only will be canceled',
                  isCancelFirstStep: true,
                  firstButtonFunction: (){},
                  secondButtonFunction: (){},
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: RideCanceledAndReportedBottomSheet(
                    headTitle: 'Ride Canceled',
                    lottiePath: 'assets/lottie/congratulation.json',
                    headerMsg: 'Ride has been canceled',
                    subHeaderMsg: "Thank you for being kind and save others' time.",
                  ),
                ),
                const RideCanceledAndReportedBottomSheet(
                  headTitle: 'Ride Reported',
                  lottiePath: 'assets/lottie/congratulation.json',
                  headerMsg: 'We feel sorry for you',
                  subHeaderMsg: "We received your report successfully, and we will try to resolve the issue very soon.",
                  isReportFirstStep: true,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: RideCanceledAndReportedBottomSheet(
                    headTitle: 'Ride Reported',
                    lottiePath: 'assets/lottie/congratulation.json',
                    headerMsg: 'Rated submitted successfully',
                    subHeaderMsg: "Thank you, hope you have enjoyed your ride with us",
                  ),
                ),
                CancelationReasonAndReportRideBottomSheet(
                  function: (){},
                  headTitle: 'Report ride',
                  reasons: const ['Driver behaviour', 'Driver arrived late', 'Car problem', 'Other'],
                  reasonsSelectedIndex: 2,
                  controller: TextEditingController(),
                  containTextField: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: RateBottomSheet(
                    headTitle: 'Rate your trip',
                    function: (){},
                    onRatingUpdate: (rate){},
                  ),
                ),
                RideStartBottomSheet(
                  firstButtonFunction: (){},
                  secondButtonFunction: (){},
                  headTitle: 'Ride Start within 10 min',
                  fromUser: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: RideCanceledAndReportedBottomSheet(
                    headTitle: 'Cancel Ride',
                    lottiePath: 'assets/lottie/congratulation.json',
                    headerMsg: 'Are you sure to Turn-off this ride?',
                    subHeaderMsg: 'This trip will not be available until you turn it back again',
                    isCancelFirstStep: true,
                    showOrButton: true,
                    firstButtonFunction: (){},
                    secondButtonFunction: (){},
                    thirdButtonFunction: (){},
                  ),
                ),
                RateBottomSheet(
                  headTitle: 'Rate your trip',
                  function: (){},
                  onRatingUpdate: (rate){},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}