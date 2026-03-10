import 'dart:developer';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';
import 'package:girlified/components/skeletons/insecure_dashboard_content.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/core/constants/secrets.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';
import 'package:girlified/components/cards/ongoing_order_item_card.dart';
import 'package:girlified/components/buttons/grouped_header_buttons.dart';
import 'package:girlified/components/cards/completed_order_item_card.dart';
import 'package:girlified/components/skeletons/empty_results_content.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String orderType = 'Ongoing';
  RxBool fetchingPaginatedData = false.obs;

  ScrollController scrollController = ScrollController();

  final List<String> orderTypes = ['Ongoing', 'Completed'.tr];

  Future<void> initializeOrders() async {
    await ServiceRegistry.orderService.fetchUserOrdersService(
      currentPage: 1,
    );
  }

  @override
  void initState() {
    super.initState();

    initializeOrders();
    scrollController.addListener(_scrollHandler);
  }

  void _scrollHandler() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      fetchingPaginatedData.value = true;

      if (ServiceRegistry.userRepository.ordersHasNextPage.value == true) {
        await ServiceRegistry.orderService.fetchUserOrdersService(
          currentPage:
              ServiceRegistry.userRepository.ordersCurrentPage.value + 1,
        );

        fetchingPaginatedData.value = false;
      }

      fetchingPaginatedData.value = false;

      debugPrint('[END-OF-CONTENT]');
      debugPrint('[CONFIGURE-PAGINATION]');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(
          child: Container(
            // color: Colors.amber,
            height: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              // top: AppSizes.vertical_5,
              horizontal: AppSizes.horizontal_15,
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: AppSizes.horizontal_35),
                    TitleText(
                      size: 16,
                      title: 'Orders',
                    ),
                    SizedBox(width: AppSizes.horizontal_35),
                  ],
                ),
                const SizedBox(height: AppSizes.vertical_5),
                GroupedHeaderButtons(
                  currentItem: orderType,
                  buttonTypes: orderTypes,
                  onChangeHandler: (String value) {
                    log('[UPDATE-VIEW-ORDERS-TYPE] -> ${value.toUpperCase()}');

                    setState(() {
                      orderType = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 0,
        backgroundColor: AppColors.blackColor,
        foregroundColor: AppColors.whiteColor,
        onPressed: () {
          if (ServiceRegistry.localStorage
                  .read(LocalStorageSecrets.authenticationMethod) ==
              'GUEST') {
            customErrorMessageSnackbar(
              title: 'Message',
              message: 'Login to create an order!',
            );

            Get.toNamed(AppRoutes.loginRoute);
          } else {
            Get.toNamed(AppRoutes.orderPadRoute);
          }
        },
        child: const Icon(FluentIcons.add_16_regular),
      ),
      body: RefreshIndicator(
        onRefresh: initializeOrders,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: ServiceRegistry.localStorage
                            .read(LocalStorageSecrets.authenticationMethod) ==
                        'GUEST'
                    ? const InsecureDashboardContent()
                    : Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.horizontal_15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              orderType == 'Ongoing'
                                  ? const SizedBox(height: AppSizes.vertical_10)
                                  : const SizedBox(),
                              orderType == 'Completed'
                                  ? const SizedBox(height: AppSizes.vertical_10)
                                  : const SizedBox(),
                              orderType == 'Ongoing'
                                  ? ServiceRegistry
                                          .userRepository.ongoingOrders.isEmpty
                                      ? const EmptyResultsContent(
                                          displayType: 'ONGOING_ORDERS',
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: ServiceRegistry
                                              .userRepository
                                              .ongoingOrders
                                              .length,
                                          itemBuilder: (_, index) {
                                            return OngoingOrderItemCard(
                                              orderInfo: ServiceRegistry
                                                  .userRepository
                                                  .ongoingOrders[index],
                                            );
                                          },
                                        )
                                  : const SizedBox(),
                              orderType == 'Completed'
                                  ? ServiceRegistry.userRepository
                                          .completedOrders.isEmpty
                                      ? const EmptyResultsContent(
                                          displayType: 'COMPLETED_ORDERS',
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: ServiceRegistry
                                              .userRepository
                                              .completedOrders
                                              .length,
                                          itemBuilder: (_, index) {
                                            return CompletedOrderItemCard(
                                              orderInfo: ServiceRegistry
                                                  .userRepository
                                                  .completedOrders[index],
                                            );
                                          },
                                        )
                                  : const SizedBox(),
                              const SizedBox(height: AppSizes.vertical_50),
                            ],
                          ),
                        ),
                      ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: (int value) {
          ServiceRegistry.commonRepository.currentScreenIndex.value = value;
        },
        currentPage: ServiceRegistry.commonRepository.currentScreenIndex.value,
      ),
    );
  }
}
