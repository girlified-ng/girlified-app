import 'package:flutter/material.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/body_text.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> dropDownItems;
  final Function(String?) onChanged;
  final String? value;

  const CustomDropdownButton({
    super.key,
    required this.dropDownItems,
    required this.onChanged,
    this.value,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    initializeSelectedItem();
  }

  @override
  void didUpdateWidget(CustomDropdownButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-initialize selected item if the dropdown items or value changes
    if (oldWidget.dropDownItems != widget.dropDownItems ||
        oldWidget.value != widget.value) {
      initializeSelectedItem();
    }
  }

  void initializeSelectedItem() {
    setState(() {
      selectedItem =
          widget.value != null && widget.dropDownItems.contains(widget.value)
              ? widget.value
              : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grayLightColor,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: Image.asset(
            'assets/icons/icon_dropdown.png',
            width: 20,
          ),
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
          isExpanded: true,
          value: selectedItem,
          hint: BodyText(
            text: '-',
            color: AppColors.grayLightColor,
          ),
          items: widget.dropDownItems.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedItem = newValue;
            });
            widget.onChanged(newValue);
          },
        ),
      ),
    );
  }
}
