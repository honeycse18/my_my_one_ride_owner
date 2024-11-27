import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:one_ride_car_owner/controller/select_location_screen_controller.dart';
import 'package:one_ride_car_owner/utils/app_singleton.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return GetBuilder<SelectLocationScreenController>(
      global: false,
      init: SelectLocationScreenController(),
      builder: (controller) => Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: AppColors.mainBg,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            hasBackButton: true,
            titleWidget: Text(
              controller.screenTitle,
              style: const TextStyle(color: Colors.black),
            )),
        body: Stack(
          children: [
            SizedBox(
                height: screenHeight,
                child: GoogleMap(
                  mapType: MapType.normal,
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition:
                      AppSingleton.instance.defaultCameraPosition,
                  markers: controller.googleMapMarkers,
                  onMapCreated: controller.onGoogleMapCreated,
                  onTap: controller.onGoogleMapTap,
                )),
            if (controller.mapMarked)
              Positioned(
                  width: MediaQuery.of(context).size.width,
                  bottom: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomStretchedButtonWidget(
                      onTap: controller.onConfirmLocationButtonTap,
                      child: Text(AppLanguageTranslation
                          .confirmLocTransKey.toCurrentLanguage),
                    ),
                  )),
            if (controller.showCurrentLocation)
              Positioned(
                right: 30,
                bottom: controller.mapMarked ? 150 : 30,
                child: GestureDetector(
                  onTap: () => controller.getCurrentPosition(context),
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SvgPictureAssetWidget(
                          AppAssetImages.locationSVGLogoLine,
                          color: AppColors.mainTextColor,
                        ),
                      )),
                ),
              ),
            ScaffoldBodyWidget(
                child: Column(children: [
              if (Platform.isIOS) AppGaps.hGap60,
              if (Platform.isAndroid) AppGaps.hGap90,
              Center(
                child: TypeAheadField(
                  errorBuilder: (context, error) => Center(
                    child: Text(
                      AppLanguageTranslation
                          .errorHappenTransKey.toCurrentLanguage,
                      style: TextStyle(color: AppColors.alertColor),
                    ),
                  ),
                  textFieldConfiguration: TextFieldConfiguration(
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      fillColor: AppColors.mainTextColor,
                      hintText: controller.screenTitle,
                      hintStyle: const TextStyle(
                        color: AppColors.bodyTextColor,
                      ),
                      prefix: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: SvgPictureAssetWidget(
                            AppAssetImages.locationSVGLogoLine),
                      ),
                    ),
                    onTap: () {
                      controller.keyBoardHidden = !controller.keyBoardHidden;
                      if (controller.keyBoardHidden) {
                        Helper.hideKeyBoard();
                      }
                    },
                    focusNode: controller.focusSearchBox,
                    controller: controller.locationTextEditingController,
                    onTapOutside: (event) => Helper.hideKeyBoard(),
                  ),
                  itemBuilder: (context, Prediction suggestion) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.bodyTextColor,
                        ),
                        AppGaps.wGap10,
                        Expanded(
                          child: Text(suggestion.description!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.bodyTextColor,
                                fontSize: 15,
                              )),
                        ),
                      ]),
                    );
                  },
                  itemSeparatorBuilder: (context, index) => Container(
                    height: 1,
                    color: AppColors.bodyTextColor,
                  ),
                  suggestionsCallback: (pattern) async {
                    return await controller.searchLocation(context, pattern);
                  },
                  onSuggestionSelected: (Prediction suggestion) {
                    log('My location is :  ${suggestion.description!}');
                    controller.setLocation(
                        suggestion.placeId!,
                        suggestion.description!,
                        controller.googleMapController);
                  },
                ) /* CustomTextFormField(
                      onTap: () => Get.dialog(LocationSearchDialog(
                          mapController: controller.googleMapController)),
                      controller: controller.locationTextEditingController,
                      prefixIcon: const SvgPictureAssetWidget(
                          AppAssetImages.locationSVGLogoLine),
                      hintText: 'Search Location',
                    ) */
                ,
              )
            ]))
          ],
        ),
      ),
    );
  }
}
