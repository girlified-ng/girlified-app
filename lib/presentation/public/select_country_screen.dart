import 'dart:io';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/utilities/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/custom_text_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:girlified/components/form/custom_search_field.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';

class SelectCountryScreen extends StatefulWidget {
  final String currentDialCode;
  final Function onSelectHandler;
  const SelectCountryScreen({
    super.key,
    required this.currentDialCode,
    required this.onSelectHandler,
  });

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  List filteredCountries = [];

  TextEditingController searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCountries = platformCountries;

    searchQueryController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    searchQueryController.removeListener(_filterCountries);
    searchQueryController.dispose();
    super.dispose();
  }

  void _filterCountries() {
    String query = searchQueryController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        filteredCountries = platformCountries;
      } else {
        filteredCountries = platformCountries.where((country) {
          return country['name'].toString().toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: AppColors.whiteColor,
            padding: const EdgeInsets.only(
              // bottom: AppSizes.vertical_10,
              left: AppSizes.horizontal_15,
              right: AppSizes.horizontal_15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(),
                    TitleText(
                      size: 16,
                      weight: FontWeight.w500,
                      title: 'Select a country',
                    ),
                    SizedBox(width: AppSizes.horizontal_30),
                  ],
                ),
                Container(
                  height: 48,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontal_10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.borderPrimaryColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/icon_search.png',
                        width: 20,
                        color: AppColors.borderPrimaryColor,
                      ),
                      Expanded(
                        child: CustomSearchField(
                          maxLines: 1,
                          paddingTop: Platform.isAndroid ? -10 : -5,
                          borderRadius: 16,
                          width: double.maxFinite,
                          height: double.maxFinite,
                          hintText: 'Search for a country',
                          keyboardType: TextInputType.name,
                          borderColor: Colors.transparent,
                          controller: searchQueryController,
                          textColor: AppColors.primaryTextColor,
                          hintColor: AppColors.borderPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox()
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.horizontal_15,
            ),
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.vertical_10),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredCountries.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          widget.onSelectHandler(
                              filteredCountries[index]['dialCode']);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.vertical_10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CustomTextWidget(
                                    size: 20,
                                    text: filteredCountries[index]['flagEmoji'],
                                  ),
                                  const SizedBox(width: AppSizes.horizontal_8),
                                  BodyText(
                                      text: filteredCountries[index]['name']),
                                  const SizedBox(width: AppSizes.horizontal_8),
                                  BodyText(
                                    text:
                                        '(${filteredCountries[index]['dialCode']})',
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: widget.currentDialCode ==
                                    filteredCountries[index]['dialCode'],
                                child: const Icon(
                                  FluentIcons.checkmark_12_regular,
                                  color: AppColors.greenColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
              ],
            )),
      ),
    );
  }
}
