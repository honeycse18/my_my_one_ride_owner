import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/select_payment_methods_screen_controller_hire_driver.dart';
import 'package:one_ride_car_owner/models/fakeModel/fake_data.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/select_payment_method_widget.dart';

class HireDriverSelectPaymentMethodsScreen extends StatelessWidget {
  const HireDriverSelectPaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HireDriverSelectPaymentMethodScreenController>(
        global: false,
        init: HireDriverSelectPaymentMethodScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .selectPaymentTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap24,
                  ),
                  SliverList.separated(
                    itemCount: FakeData.paymentOptionList.length,
                    itemBuilder: (context, index) {
                      final paymentOption = FakeData.paymentOptionList[index];
                      return SelectPaymentMethodWidget(
                        paymentOptionImage: paymentOption.paymentImage,
                        cancelReason: paymentOption,
                        selectedCancelReason: controller.selectedPaymentOption,
                        paymentOption: paymentOption.viewAbleName,
                        hasShadow:
                            controller.selectedPaymentMethodIndex == index,
                        onTap: () {
                          controller.selectedPaymentMethodIndex = index;
                          controller.selectedPaymentOption = paymentOption;
                          controller.update();
                        },
                        radioOnChange: (Value) {
                          controller.selectedPaymentMethodIndex = index;
                          controller.selectedPaymentOption = paymentOption;
                          controller.update();
                        },
                        index: index,
                        selectedPaymentOptionIndex:
                            controller.selectedPaymentMethodIndex,
                      );
                    },
                    separatorBuilder: (context, index) => AppGaps.hGap16,
                  ),
                ],
              )),
              bottomNavigationBar: ScaffoldBodyWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomStretchedButtonWidget(
                      onTap: controller.paymentAcceptHireDriverRequest,
                      child: Text(AppLanguageTranslation
                          .paymentTransKey.toCurrentLanguage),
                    ),
                    AppGaps.hGap10,
                  ],
                ),
              ),
            ));
  }
}
