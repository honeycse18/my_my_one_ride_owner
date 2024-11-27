import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:one_ride_car_owner/controller/select_location_screen_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';

class LocationSearchDialog extends StatelessWidget {
  final GoogleMapController? mapController;
  const LocationSearchDialog({required this.mapController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectLocationScreenController>(
        global: false,
        init: SelectLocationScreenController(),
        builder: ((controller) => Container(
              margin: const EdgeInsets.only(top: 150),
              padding: const EdgeInsets.all(5),
              alignment: Alignment.topCenter,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: SizedBox(
                    width: 350,
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controller.searchTextController,
                        textInputAction: TextInputAction.search,
                        autofocus: true,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          hintText: AppLanguageTranslation.searchTransKey.toCurrentLanguage,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                style: BorderStyle.none, width: 0),
                          ),
                          hintStyle:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    fontSize: 16,
                                    color: AppColors.mainTextColor,
                                  ),
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                        ),
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
                              fontSize: 20,
                            ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await controller.searchLocation(
                            context, pattern);
                      },
                      itemBuilder: (context, Prediction suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(children: [
                            const Icon(Icons.location_on),
                            Expanded(
                              child: Text(suggestion.description!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color,
                                        fontSize: 20,
                                      )),
                            ),
                          ]),
                        );
                      },
                      onSuggestionSelected: (Prediction suggestion) {
                        log('My location is :  ${suggestion.description!}');
                        controller.setLocation(suggestion.placeId!,
                            suggestion.description!, mapController);
                        Get.back();
                      },
                    )),
              ),
            )));
  }
}
