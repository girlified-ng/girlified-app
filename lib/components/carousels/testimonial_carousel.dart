import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/small_text.dart';
import 'package:girlified/data/infra_sdk/engagement/lib/engagement_sdk.dart';
import 'package:girlified/components/images/cached_network_image_widget.dart';

class TestimonialCarousel extends StatefulWidget {
  final bool hasBorder;
  final int timerInterval;
  final double titleSize;
  final double bodySize;
  final double borderRadius;
  final int testimonialIndex;
  final String avatarDisplay;
  final Color backgroundColor;

  const TestimonialCarousel({
    super.key,
    this.bodySize = 14,
    this.titleSize = 12,
    this.timerInterval = 5,
    this.borderRadius = 16,
    this.hasBorder = false,
    this.testimonialIndex = 0,
    this.avatarDisplay = 'ROW',
    this.backgroundColor = AppColors.whiteColor,
  });

  @override
  State<TestimonialCarousel> createState() => _TestimonialCarouselState();
}

class _TestimonialCarouselState extends State<TestimonialCarousel> {
  Timer? _timer;
  int currentIndex;
  RxBool showTestimonials = false.obs;
  TestimonialInfo testimonial = TestimonialInfo((instance) => instance
    ..id = ''
    ..avatarUrl = ''
    ..author = ''
    ..testimonial = ''
    ..createdAt = DateTime.now());

  _TestimonialCarouselState() : currentIndex = 0;

  void initializeTimeout() async {
    await Future.delayed(const Duration(milliseconds: 3500));

    if (ServiceRegistry.userRepository.testimonials.isNotEmpty) {
      currentIndex = widget.testimonialIndex %
          ServiceRegistry.userRepository.testimonials.length;
      testimonial = ServiceRegistry.userRepository.testimonials[currentIndex];
      showTestimonials.value = true;

      _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        if (mounted) {
          setState(() {
            currentIndex = (currentIndex + 1) %
                ServiceRegistry.userRepository.testimonials.length;
            testimonial =
                ServiceRegistry.userRepository.testimonials[currentIndex];
          });
        } else {
          _timer?.cancel();
        }
      });
    }
  }

  @override
  void initState() {
    initializeTimeout();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return showTestimonials.isTrue
          ? Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: widget.hasBorder
                      ? AppColors.grayLightColor
                      : Colors.transparent,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  widget.avatarDisplay == 'ROW'
                      ? Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: CachedNetworkImageWidget(
                                width: 45,
                                height: 45,
                                imageUrl: testimonial.avatarUrl!,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SmallText(
                                      size: widget.titleSize,
                                      weight: FontWeight.bold,
                                      text: testimonial.author!,
                                    ),
                                    const SizedBox(width: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        5,
                                        (index) {
                                          return const Icon(
                                            Icons.star,
                                            size: 15,
                                            color: AppColors.orangeColor,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SmallText(
                                  size: widget.bodySize,
                                  text: testimonial.age!,
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const SizedBox(width: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                5,
                                (index) {
                                  return const Icon(
                                    Icons.star,
                                    size: 15,
                                    color: AppColors.orangeColor,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 5),
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(500),
                                  child: CachedNetworkImageWidget(
                                    width: 45,
                                    height: 45,
                                    imageUrl: testimonial.avatarUrl ??
                                        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmallText(
                                      size: widget.titleSize,
                                      weight: FontWeight.bold,
                                      text: testimonial.author!,
                                    ),
                                    SmallText(
                                      size: widget.bodySize,
                                      text: testimonial.age!,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                  const SizedBox(height: 5),
                  SmallText(
                    lineHeight: 1.6,
                    size: widget.bodySize,
                    alignment: TextAlign.center,
                    text: testimonial.testimonial!,
                  ),
                  const SizedBox(height: 5),
                  Visibility(
                    visible: testimonial.handle != ' ',
                    child: Row(
                      children: [
                        SmallText(
                          lineHeight: 1.6,
                          size: widget.bodySize,
                          text: testimonial.handle!,
                        ),
                        SmallText(
                          lineHeight: 1.6,
                          size: widget.bodySize,
                          text: " - ${testimonial.platform!}",
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 5),
                ],
              ),
            )
          : const SizedBox();
    });
  }
}
