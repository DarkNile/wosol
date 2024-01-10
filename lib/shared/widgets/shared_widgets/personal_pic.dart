import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wosol/shared/constants/style/colors.dart';
import 'package:wosol/shared/widgets/shared_widgets/custom_text_fields.dart';

class PersonalPicture extends StatelessWidget {
  const PersonalPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/avatar.png"),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
          Positioned(
            top: 64,
            left: 64.5,
            right: -.5,
            child: Container(
              width: 32,
              height: 32,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: AppColors.logo,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: SvgPicture.asset("assets/icons/gallery-add.svg"),
            ),
          ),
         
        ],
      ),
    );
  }
}
