import 'package:girlified/components/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:girlified/components/text/subtitle_text.dart';
import 'package:girlified/components/text/custom_text_widget.dart';

class ColumnText extends StatelessWidget {
  final String label;
  final String value;
  final double? labelSize;
  final Color? labelColor;
  final double? valueSize;
  final Color? valueColor;

  const ColumnText({
    super.key,
    required this.label,
    required this.value,
    this.labelSize,
    this.labelColor,
    this.valueSize,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title: label,
          size: labelSize,
          color: labelColor,
          weight: FontWeight.w400,
        ),
        SubtitleText(
          text: value,
          size: valueSize,
          color: valueColor,
        ),
      ],
    );
  }
}
