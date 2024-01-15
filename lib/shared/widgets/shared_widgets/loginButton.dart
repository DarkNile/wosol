import 'package:flutter/material.dart';
import 'package:wosol/shared/widgets/shared_widgets/buttons.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.color, required this.height,
  });
  final String text;
  final Color color;
  final double height;
  @override
  Widget build(BuildContext context) {
    // todo : why padding padding should be inSide Button not outSide
    return DefaultButton(
      function: () {},
      height: height,
      text: text,
      color: color,
    );
  }
}
