import 'package:flutter/material.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    // todo : why padding padding should be inSide Button not outSide
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 12,
      ),
      // todo : You User default height = 53 look at figma
      child: DefaultButton(
        function: () {},
        text: text,
      ),
    );
  }
}
