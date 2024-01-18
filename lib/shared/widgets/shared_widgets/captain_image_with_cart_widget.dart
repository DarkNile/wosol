import 'package:flutter/material.dart';
import 'package:wosol/shared/constants/style/colors.dart';

class CaptainImageWithCartWidget extends StatelessWidget {
  const CaptainImageWithCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          width: 89,
          height: 46,
        ),
        Positioned(
          right: -9,
          child: Image.asset(
            'assets/images/car.png',
            width: 80,
            height: 46,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: 46,
            height: 46,
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            ),
          ),
        ),
      ],
    );
  }
}
