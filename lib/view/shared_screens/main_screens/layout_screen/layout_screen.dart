import 'package:flutter/material.dart';
import 'package:wosol/shared/widgets/shared_widgets/bottom_sheets.dart';
import 'package:wosol/view/shared_screens/auth/edit_profile.dart';
import 'package:wosol/view/shared_screens/auth/login_screen.dart';
import 'package:wosol/view/shared_screens/auth/settings_screen.dart';

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
                  child: CancellationReasonAndReportRideBottomSheet(
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
                    imagePath: 'assets/images/celebrate.png',
                    lottiePath: 'assets/lottie/success.json',
                    containLottie: true,
                    headerMsg: 'Congratulations ',
                    subHeaderMsg: 'ride completed successfully, Thank you',
                  ),
                ),
                RideAndTripEndBottomSheet(
                  function: (){},
                  headTitle: 'Ride end',
                  imagePath: 'assets/images/celebrate.png',
                  lottiePath: 'assets/lottie/success.json',
                  containLottie: true,
                  headerMsg: 'Congratulations ',
                  subHeaderMsg: 'ride completed successfully, Thank you',
                  isTrip: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TripCompletedBottomSheet(
                    imagePath: 'assets/images/end.png',
                    headerMsg: 'Trip Completed?',
                    function: (){},
                  ),
                ),
                RideCanceledAndReportedBottomSheet(
                  headTitle: 'Cancel Ride',
                  imagePath: 'assets/images/thinking.png',
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
                    imagePath: 'assets/images/smile.png',
                    headerMsg: 'Ride has been canceled',
                    subHeaderMsg: "Thank you for being kind and save others' time.",
                  ),
                ),
                const RideCanceledAndReportedBottomSheet(
                  headTitle: 'Ride Reported',
                  imagePath: 'assets/images/sad.png',
                  headerMsg: 'We feel sorry for you',
                  subHeaderMsg: "We received your report successfully, and we will try to resolve the issue very soon.",
                  isReportFirstStep: true,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: RideCanceledAndReportedBottomSheet(
                    headTitle: 'Ride Reported',
                    imagePath: 'assets/images/star.png',
                    headerMsg: 'Rated submitted successfully',
                    subHeaderMsg: "Thank you, hope you have enjoyed your ride with us",
                  ),
                ),
                CancellationReasonAndReportRideBottomSheet(
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
                    selectIssue: false,
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
                    imagePath: 'assets/images/thinking.png',
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
                  selectIssue: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
