import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wosol/shared/constants/style/fonts.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_phone_field.dart';
import 'package:wosol/shared/widgets/shared_widgets/emailTextField.dart';
import 'package:wosol/shared/widgets/shared_widgets/personal_pic.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 34,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/icons/arrow-left.svg",
            ),
          ),
        ),
        title: Text(
          "Edit personal information",
          style: AppFonts.header,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [PersonalPicture(), EmailField(),
         CustomPhoneField()],
      ),
    );
  }
}
