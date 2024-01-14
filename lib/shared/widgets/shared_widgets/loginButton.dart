import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/constants.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.text,
  });
final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 14, left: 14),
      child: DefaultButton(
        function: () {},
        text: text,
      ),
    );
  }
}
