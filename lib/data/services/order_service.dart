// ignore_for_file: library_prefixes, use_build_context_synchronously
import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/secrets.dart';
import 'package:girlified/data/services/guards/auth_guard.dart';
import 'package:account_sdk/account_sdk.dart';

class OrderService extends GetxController {
  RxBool isCreateSanitaryPadOrderProcessing = false.obs;

  //! FETCH USER ORDERS
  /// Fetch ongoing orders.
  ///
  /// [METHOD] - GET
  ///
  /// [ROUTE] - /account/me/orders
  ///
  /// [IS-AUTHENTICATED]
  Future<void> fetchUserOrdersService({
    int pageSize = 20,
    required int currentPage,
  }) async {
    return authGuard<void>(() async {
      try {
        log("[FETCH-USER-ORDERS-PENDING]");

        OrderApi orderApi = ServiceRegistry.accountSdk.getOrderApi();

        Dio.Response response =
            await orderApi.orderControllerFetchSanitaryPadOrderHistory(
          page: currentPage,
          pageSize: pageSize,
          headers: {
            "Authorization": ServiceRegistry.localStorage.read(
              LocalStorageSecrets.accessToken,
            ),
          },
        );

        if (response.statusCode == 200) {
          // log('[FETCH-DETAILED-USER-ACCOUNT-INFO-RESPONSE] :: ${response.data}');

          OrderHistoryResponse orderHistoryResponse = response.data;

          if (currentPage == 1) {
            ServiceRegistry.userRepository.ongoingOrders.value =
                orderHistoryResponse.orders
                    .where((order) => order.isCompleted == false)
                    .toList();
            ServiceRegistry.userRepository.completedOrders.value =
                orderHistoryResponse.orders
                    .where((order) => order.isCompleted == true)
                    .toList();
          } else {
            ServiceRegistry.userRepository.ongoingOrders.addAll(
                orderHistoryResponse.orders
                    .where((order) => order.isCompleted == false)
                    .toList());
            ServiceRegistry.userRepository.completedOrders.addAll(
                orderHistoryResponse.orders
                    .where((order) => order.isCompleted == true)
                    .toList());
          }

          ServiceRegistry.userRepository.ordersCurrentPage.value = currentPage;
          ServiceRegistry.userRepository.ordersHasNextPage.value =
              orderHistoryResponse.hasNext;

          log("[FETCH-USER-ORDERS-SUCCESS]");
        }
      } catch (error) {
        log('[FETCH-USER-ORDERS-ERROR-RESPONSE] :: $error');

        if (error is Dio.DioException) {
          Dio.DioException dioError = error;

          log('[FETCH-USER-ORDERS-DIO-ERROR-RESPONSE] :: ${dioError.response}');
        }
      }
    });
  }

  //! CREATE SANITARY PAD ORDER
  /// Create sanitary pad order.
  ///
  /// [METHOD] - POST
  ///
  /// [ROUTE] - /account/me/orders/sanitary-pad
  ///
  /// [IS-AUTHENTICATED]
  Future<void> createSanitaryPadOrderService(
      OrderSanitaryPadDTO payload) async {
    return authGuard<void>(() async {
      try {
        log("[CREATE-SANITARY-PAD-ORDER-PENDING]");

        isCreateSanitaryPadOrderProcessing.value = true;

        OrderApi orderApi = ServiceRegistry.accountSdk.getOrderApi();

        Dio.Response response = await orderApi.orderControllerOrderSanitaryPad(
          orderSanitaryPadDTO: payload,
          headers: {
            "Authorization": ServiceRegistry.localStorage.read(
              LocalStorageSecrets.accessToken,
            ),
          },
        );

        if (response.statusCode == 201) {
          log('[CREATE-SANITARY-PAD-ORDER-RESPONSE] :: ${response.data}');

          OrderInfo data = response.data;

          ServiceRegistry.userRepository.ongoingOrders.insert(0, data);

          Get.offAllNamed(AppRoutes.dashboardRoute);

          customSuccessMessageSnackbar(
            title: 'Message',
            message: 'Sanitary pad order created successfully',
          );

          log("[CREATE-SANITARY-PAD-ORDER-SUCCESS]");

          isCreateSanitaryPadOrderProcessing.value = false;
        }
      } catch (error) {
        isCreateSanitaryPadOrderProcessing.value = false;

        log('[CREATE-SANITARY-PAD-ORDER-ERROR-RESPONSE] :: $error');

        if (error is Dio.DioException) {
          Dio.DioException dioError = error;

          log('[CREATE-SANITARY-PAD-ORDER-DIO-ERROR-RESPONSE] :: ${dioError.response}');
        }
      } finally {
        isCreateSanitaryPadOrderProcessing.value = false;
      }
    });
  }
}
