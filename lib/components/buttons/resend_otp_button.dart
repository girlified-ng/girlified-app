import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/skeletons/loading_animation.dart';

class ResendOtpButton extends StatelessWidget {
  final String title;
  final String countDownText;
  final bool hasCountDown;
  final Function onTapOtpHandler;
  final bool isLoading;
  const ResendOtpButton({
    super.key,
    this.isLoading = false,
    this.hasCountDown = false,
    this.title = 'Resend code',
    required this.countDownText,
    required this.onTapOtpHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: hasCountDown ? 140 : 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSecondaryColor),
      ),
      child: Center(
        child: isLoading
            ? const LoadingAnimation(size: 20, color: AppColors.blackColor)
            : InkWell(
                onTap: () {
                  onTapOtpHandler();
                },
                overlayColor: const WidgetStatePropertyAll(
                  Colors.transparent,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: title,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight:
                              hasCountDown ? FontWeight.w500 : FontWeight.bold,
                          color: hasCountDown
                              ? AppColors.textTertiaryColor
                              : AppColors.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: hasCountDown ? ' in ' : '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: AppColors.textTertiaryColor,
                        ),
                      ),
                      TextSpan(
                        text: hasCountDown ? countDownText : '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // BodyText(
                //   weight: FontWeight.bold,
                //   text: text,
                // ),
              ),
      ),
    );
  }
}
