import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';

class GirlifiedIconBadge extends StatelessWidget {
  const GirlifiedIconBadge({super.key, this.size = 25, this.opacity = 1.0});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      // padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // border: Border.all(
        //     color: AppColors.grayLightColor.withValues(alpha: opacity)),
      ),
      child: Image.asset(
        'assets/icons/icon_saifeai_cliff.png',
        width: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
