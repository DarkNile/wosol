import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonalPicture extends StatelessWidget {
  const PersonalPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
            width: 96,
            height: 96,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cGVvcGxlfGVufDB8fDB8fHww",
              ),
            )),
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(
            "assets/icons/upload_image.svg",
            height: 32,
            width: 32,
          ),
        ),
      ],
    );
  }
}
