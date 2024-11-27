import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/api_responses/car_categories_response.dart';
import 'package:one_ride_car_owner/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_car_owner/models/api_responses/vehicle_details_response.dart';
import 'package:one_ride_car_owner/models/enums.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';
import 'package:one_ride_car_owner/utils/helpers/api_repo.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';
import 'package:one_ride_car_owner/widgets/screen_widget/dialogs.dart';

class AddVehicleScreenController extends GetxController {
  String carId = '';
  Rx<AddVehicleTabState> addVehicleState = AddVehicleTabState.step1.obs;
  var isLoading = false.obs;
  List<String> galleryImageURLs = [];
  List<dynamic> selectedVehicleImageURLs = [];
  List<dynamic> selectedDocumentsImageURLs = [];
  List<CarCategoriesCategory> carCategories = [];

  CarCategoriesCategory? selectedCategory;
  String selectedColor = 'Red';
  String selectedFuelType = 'Diesel';
  String selectedGearType = 'automatic';
  bool hasAC = false;

  TextEditingController vehicleNameTextEditingController =
      TextEditingController();
  TextEditingController vehicleModelTextEditingController =
      TextEditingController();
  TextEditingController modelYearTextEditingController =
      TextEditingController();
  TextEditingController maxPowerTextEditingController = TextEditingController();
  TextEditingController maxSpeedTextEditingController = TextEditingController();
  TextEditingController seatCapacityTextEditingController =
      TextEditingController();
  TextEditingController milageTextEditingController = TextEditingController();
  TextEditingController numberPlateTextEditingController =
      TextEditingController();
  // FileUploadController imagesUploadController = FileUploadController;

  final RxBool isSubmitAddVehicleLoading = false.obs;
  final RxBool isAddVehicleDetailsLoading = false.obs;

  void onUploadAddVehicleImageTap({bool forVehicle = true}) {
    Helper.pickImages(
        onSuccessUploadSingleImage: forVehicle
            ? _onSuccessOnUploadAddGalleryImageTap
            : _onSuccessOnUploadAddDocumentsImageTap,
        imageName: 'Vehicle Image');
  }

  void _onSuccessOnUploadAddGalleryImageTap(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    selectedVehicleImageURLs
        .addAll(rawImagesData.map((e) => e as dynamic).toList());
    update();
    Helper.showSnackBar(
        AppLanguageTranslation.updateThumbImageTransKey.toCurrentLanguage);
  }

  void _onSuccessOnUploadAddDocumentsImageTap(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    selectedDocumentsImageURLs
        .addAll(rawImagesData.map((e) => e as dynamic).toList());
    update();
    Helper.showSnackBar(
        AppLanguageTranslation.updateThumbImageTransKey.toCurrentLanguage);
  }

  void onUploadDeleteVehicleImageTap(int index) {
    try {
      selectedVehicleImageURLs.removeAt(index);
      update();
      Helper.showSnackBar(
          AppLanguageTranslation.removeThumbImageTransKey.toCurrentLanguage);
    } catch (e) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.wrongThumbImageTransKey.toCurrentLanguage);
      return;
    }
  }

  void onUploadDeleteDocumentImageTap(int index) {
    try {
      selectedDocumentsImageURLs.removeAt(index);
      update();
      Helper.showSnackBar(
          AppLanguageTranslation.removeThumbImageTransKey.toCurrentLanguage);
    } catch (e) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.wrongThumbImageTransKey.toCurrentLanguage);
      return;
    }
  }

  bool validateAddVehicle() {
    if (selectedCategory == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .mustSelectCategoryTransKey.toCurrentLanguage);
      return false;
    }
    return true;
  }

  void onSubmitButtonTap() {
    if (validateAddVehicle()) {
      addVehicle();
    }
  }

  Future<void> addVehicle() async {
    final selectedGalleryImages =
        await Future.wait(selectedVehicleImageURLs.map((e) async {
      if (e is String) {
        return e;
      } else {
        return await Helper.getTempFileFromImageBytes(e);
      }
    }).toList());
    final selectedDocumentsImages =
        await Future.wait(selectedDocumentsImageURLs.map((e) async {
      if (e is String) {
        return e;
      } else {
        return await Helper.getTempFileFromImageBytes(e);
      }
    }).toList());
    final selectedGalleryImageLinks =
        selectedGalleryImages.whereType<String>().toList();
    // selectedGalleryImageLinks.add('value');
    final selectedGalleryImageFiles =
        selectedGalleryImages.whereType<File>().toList();

    final selectedDocumentsImageLinks =
        selectedDocumentsImages.whereType<String>().toList();
    final selectedDocumentsImageFiles =
        selectedDocumentsImages.whereType<File>().toList();

    final FormData requestBody = FormData({
      'name': vehicleNameTextEditingController.text,
      'category': selectedCategory?.id ?? '',
      'model': modelYearTextEditingController.text,
      'year': modelYearTextEditingController.text,
      'max_power': maxPowerTextEditingController.text,
      'max_speed': maxSpeedTextEditingController.text,
      'capacity': seatCapacityTextEditingController.text,
      'color': selectedColor,
      'fuel_type': selectedFuelType,
      'mileage': milageTextEditingController.text,
      'gear_type': selectedGearType,
      'ac': hasAC,
      'vehicle_number': numberPlateTextEditingController.text,
      /* 'images': selectedGalleryImages.mapIndexed((index, imageRawData) {
        if (imageRawData is String) {
          return imageRawData;
        } else {
          return MultipartFile(imageRawData,
              filename: 'image_$index.jpg', contentType: 'image/jpeg');
        }
      }).toList(), */
      'images': selectedGalleryImageFiles
          .mapIndexed((index, imageRawData) => MultipartFile(imageRawData,
              filename: 'image_$index.jpg', contentType: 'image/jpeg'))
          .toList(),
      'documents': selectedDocumentsImageFiles
          .mapIndexed((index, imageRawData) => MultipartFile(imageRawData,
              filename: 'image_$index.jpg', contentType: 'image/jpeg'))
          .toList(), /* selectedDocumentsImages.mapIndexed((index, imageRawData) {
        if (imageRawData is String) {
          return imageRawData;
        } else {
          return MultipartFile(imageRawData,
              filename: 'image_doc_$index.jpg', contentType: 'image/jpeg');
        }
      }).toList(), */
    });
    // MultipartFile(data, filename: filename)
    RawAPIResponse? response;
    if (carId.isEmpty) {
      response = await APIRepo.addVehicle(requestBody);
    } else {
      requestBody.fields.add(MapEntry('_id', carId));
      /* for (var element in selectedGalleryImageLinks) {
        requestBody.fields.addAll([MapEntry('prev_images', element)]);
      } */
      requestBody.fields.addAll(
          selectedGalleryImageLinks.map((e) => MapEntry('prev_images', e)));
      /* for (var element in selectedDocumentsImageLinks) {
        requestBody.fields.addAll([MapEntry('prev_documents', element)]);
      } */
      requestBody.fields.addAll(selectedDocumentsImageLinks
          .map((e) => MapEntry('prev_documents', e)));

      // requestBody.fields
      //     .add(MapEntry('prev_images', selectedGalleryImageLinks));
      response = await APIRepo.updateVehicleDetails(requestBody);
    }
    try {
      await Future.wait(selectedGalleryImages.map((e) async {
        if (e is File) {
          return await e.delete();
        }
      }).toList());
    } catch (e) {}
    try {
      await Future.wait(selectedDocumentsImages.map((e) async {
        if (e is File) {
          return await e.delete();
        }
      }).toList());
    } catch (e) {}
    if (response == null) {
      onNullResponse(response);
      return;
    } else if (response.error) {
      onErrorResponse(response);
      return;
    }
    log(response.toJson().toString());
    onSuccessAddingVehicle(response);
  }

  onNullResponse(RawAPIResponse? response) {
    AppDialogs.showErrorDialog(
        messageText:
            AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
  }

  onErrorResponse(RawAPIResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  onSuccessAddingVehicle(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Get.back();
  }

  Future<void> getVehicleCategories() async {
    CarCategoriesResponse? response = await APIRepo.getCarCategories();
    if (response == null) {
      AppDialogs.showErrorDialog(
        messageText:
            AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage,
      );
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingCategoriesList(response);
  }

  onSuccessRetrievingCategoriesList(CarCategoriesResponse response) {
    carCategories = response.data.categories;
    update();
  }

  Future<void> getCarDetails() async {
    VehicleDetailsResponse? response =
        await APIRepo.getVehicleDetails(productId: carId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetVehicleDetailsResponse(response);
  }

  void _onSuccessGetVehicleDetailsResponse(VehicleDetailsResponse response) {
    VehicleDetailsItem vehicle = response.data;
    // selectedCategory = vehicle.category;
    vehicleNameTextEditingController.text = vehicle.name;
    vehicleModelTextEditingController.text = vehicle.model;
    modelYearTextEditingController.text = vehicle.year;
    // selectedDocumentsImageURLs.clear();
    selectedVehicleImageURLs.addAll(vehicle.images.map((e) => e).toList());

    // selectedVehicleImageURLs = vehicle.images;
    maxPowerTextEditingController.text = vehicle.maxPower;
    maxSpeedTextEditingController.text = vehicle.maxSpeed;
    seatCapacityTextEditingController.text = vehicle.capacity.toString();
    selectedColor = vehicle.color;
    selectedFuelType = vehicle.fuelType;
    milageTextEditingController.text = vehicle.mileage.toString();
    selectedGearType = vehicle.gearType;
    hasAC = vehicle.ac;
    numberPlateTextEditingController.text = vehicle.vehicleNumber;
    selectedDocumentsImageURLs.addAll(vehicle.documents);
    final foundSelectedCarCategory = carCategories
        .firstWhereOrNull((element) => element.id == vehicle.category.id);
    if (foundSelectedCarCategory != null) {
      selectedCategory = foundSelectedCarCategory;
    }
    // vehicleDetailsItem = response.data;
    // images = response.data.images;
    // documents = response.data.documents;
    log('Fetch success!');
    update();
  }

  getScreenParameters() {
    dynamic param = Get.arguments;
    if (param is String) {
      carId = param;
    }
    update();
  }

  @override
  void onInit() async {
    await getScreenParameters();
    await getVehicleCategories();
    if (carId.isNotEmpty) {
      getCarDetails();
    }
    super.onInit();
  }

  List<Widget> currentOrderDetailsTabContentWidgets(
      AddVehicleTabState addVehicleTabState) {
    switch (addVehicleTabState) {
      case AddVehicleTabState.step1:
        return step1TabContentWidgets();
      case AddVehicleTabState.step2:
        return step2TabContentWidgets();
      case AddVehicleTabState.step3:
        return completeTabContentWidgets();
      default:
        return step1TabContentWidgets();
    }
  }

  List<Widget> step1TabContentWidgets() {
    return [
      Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLanguageTranslation.vehicleFeatureTransKey.toCurrentLanguage,
              style: AppTextStyles.titleSemiSmallBoldTextStyle,
            ),
            AppGaps.hGap20,
            DropdownButtonFormFieldWidget(
              hintText: carCategories.firstOrNull?.name ??
                  AppLanguageTranslation.noCategoryTransKey.toCurrentLanguage,
              value: selectedCategory,
              labelText: AppLanguageTranslation
                  .vehicleCategoryTransKey.toCurrentLanguage,
              items: carCategories,
              getItemText: (p0) => p0.name,
              onChanged: (selectedItem) {
                selectedCategory = selectedItem;
                update();
              },
            ),
            AppGaps.hGap16,
            CustomTextFormField(
              controller: vehicleNameTextEditingController,
              labelText:
                  AppLanguageTranslation.vehicleNameTransKey.toCurrentLanguage,
              hintText: 'e.g. Odi 2019',
            ),
            AppGaps.hGap16,
            CustomTextFormField(
              controller: vehicleModelTextEditingController,
              labelText: AppLanguageTranslation.modelTransKey.toCurrentLanguage,
              hintText: 'Odi',
            ),
            AppGaps.hGap16,
            CustomTextFormField(
              isRequired: true,
              controller: modelYearTextEditingController,
              labelText:
                  AppLanguageTranslation.modelYearTransKey.toCurrentLanguage,
              hintText: 'eg: 2019',
            ),
            AppGaps.hGap16,
            selectedVehicleImageURLs.isEmpty
                ? MultiImageUploadSectionWidget(
                    label: AppLanguageTranslation
                        .vehicleImageTransKey.toCurrentLanguage,
                    isRequired: true,
                    imageURLs: galleryImageURLs,
                    onImageUploadTap: onUploadAddVehicleImageTap,
                  )
                : SelectedLocalImageWidget(
                    label: AppLanguageTranslation
                        .vehicleImageTransKey.toCurrentLanguage,
                    isRequired: true,
                    imageURLs: galleryImageURLs,
                    onImageUploadTap: onUploadAddVehicleImageTap,
                    imagesBytes: selectedVehicleImageURLs,
                    onImageDeleteTap: onUploadDeleteVehicleImageTap,
                  ),
            AppGaps.hGap10,
          ])
    ];
  }

  List<Widget> step2TabContentWidgets() {
    return [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          AppLanguageTranslation.vehicleSpecTransKey.toCurrentLanguage,
          style: AppTextStyles.titleSemiSmallBoldTextStyle,
        ),
        AppGaps.hGap20,
        CustomTextFormField(
          isRequired: true,
          controller: maxPowerTextEditingController,
          textInputType: TextInputType.number,
          labelText: AppLanguageTranslation.mxPowerTransKey.toCurrentLanguage,
          hintText: 'e.g. 375',
        ),
        AppGaps.hGap16,
        CustomTextFormField(
          isRequired: true,
          controller: maxSpeedTextEditingController,
          textInputType: TextInputType.number,
          labelText: AppLanguageTranslation.mxSpeedTransKey.toCurrentLanguage,
          hintText: 'e.g. 250',
        ),
        AppGaps.hGap16,
        CustomTextFormField(
          isRequired: true,
          textInputType: TextInputType.number,
          controller: seatCapacityTextEditingController,
          labelText:
              AppLanguageTranslation.seatCapacityTransKey.toCurrentLanguage,
          hintText: 'e.g. 4',
        ),
        AppGaps.hGap16,
        DropdownButtonFormFieldWidget(
          hintText: 'e.g. Red',
          labelText:
              AppLanguageTranslation.vehicleColorTransKey.toCurrentLanguage,
          value: selectedColor.isNotEmpty ? selectedColor : '',
          items: const ['Red', 'Green', 'Black', 'Blue'],
          getItemText: (p0) => p0,
          onChanged: (selectedItem) {
            selectedColor = selectedItem ?? '';
          },
        ),
        AppGaps.hGap16,
        DropdownButtonFormFieldWidget(
          hintText: 'e.g. Water',
          labelText: AppLanguageTranslation.fuelTypeTransKey.toCurrentLanguage,
          value: selectedFuelType.isNotEmpty ? selectedFuelType : null,
          items: const ['Octane', 'Petrol', 'Diesel', 'Water'],
          getItemText: (p0) => p0,
          onChanged: (selectedItem) {
            selectedFuelType = selectedItem ?? '';
          },
        ),
        AppGaps.hGap16,
        CustomTextFormField(
          isRequired: true,
          textInputType: TextInputType.number,
          controller: milageTextEditingController,
          labelText: AppLanguageTranslation.milageTransKey.toCurrentLanguage,
          hintText: 'e.g. 4',
        ),
        AppGaps.hGap16,
        DropdownButtonFormFieldWidget(
          labelText: AppLanguageTranslation.gearTypeTransKey.toCurrentLanguage,
          hintText: 'e.g. Manual',
          value: selectedGearType.isNotEmpty ? selectedGearType : '',
          items: const ['automatic', 'manual'],
          getItemText: (p0) => p0,
          onChanged: (selectedItem) {
            selectedGearType = selectedItem ?? '';
          },
        ),
        AppGaps.hGap16,
        DropdownButtonFormFieldWidget(
          labelText: 'Ac',
          hintText: 'e.g. yes',
          value: hasAC ? 'Yes' : 'No',
          items: const ['Yes', 'No'],
          getItemText: (p0) => p0,
          onChanged: (selectedItem) {
            hasAC = selectedItem == 'Yes';
          },
        ),
        AppGaps.hGap10,
      ])
    ];
  }

  List<Widget> completeTabContentWidgets() {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLanguageTranslation.vehicleDocumentTransKey.toCurrentLanguage,
            style: AppTextStyles.titleSemiSmallBoldTextStyle,
          ),
          AppGaps.hGap20,
          CustomTextFormField(
            isRequired: true,
            textInputType: TextInputType.number,
            controller: numberPlateTextEditingController,
            labelText:
                AppLanguageTranslation.numberPlateTransKey.toCurrentLanguage,
            hintText: 'e.g. 2AMDFS43',
          ),
          AppGaps.hGap16,
          selectedDocumentsImageURLs.isEmpty
              ? MultiImageUploadSectionWidget(
                  label: AppLanguageTranslation
                      .vehicleRegDocumentTransKey.toCurrentLanguage,
                  isRequired: true,
                  imageURLs: galleryImageURLs,
                  onImageUploadTap: () =>
                      onUploadAddVehicleImageTap(forVehicle: false),
                )
              : SelectedLocalImageWidget(
                  label: AppLanguageTranslation
                      .vehicleRegDocumentTransKey.toCurrentLanguage,
                  isRequired: true,
                  imageURLs: galleryImageURLs,
                  onImageUploadTap: () =>
                      onUploadAddVehicleImageTap(forVehicle: false),
                  imagesBytes: selectedDocumentsImageURLs,
                  onImageDeleteTap: onUploadDeleteDocumentImageTap,
                ),
          AppGaps.hGap10,
        ],
      )
    ];
  }

  Widget currentOrderDetailsTabBottomButtonWidget(
      AddVehicleTabState addVehicleStateValue) {
    Map<AddVehicleTabState, Widget> addVehicleStateWidgetMap = {
      AddVehicleTabState.step1: isSubmitAddVehicleLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : StretchedTextButtonWidget(
              buttonText: AppLanguageTranslation.nextTransKey.toCurrentLanguage,
              onTap: () async {
                // await submitOrderCreate();
                addVehicleState.value = AddVehicleTabState.step2;
              }),
      AddVehicleTabState.step2: isAddVehicleDetailsLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : StretchedTextButtonWidget(
              buttonText: AppLanguageTranslation.nextTransKey.toCurrentLanguage,
              onTap: () async {
                addVehicleState.value = AddVehicleTabState.step3;
              }),
      AddVehicleTabState.step3: isAddVehicleDetailsLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : StretchedTextButtonWidget(
              buttonText:
                  AppLanguageTranslation.submitTransKey.toCurrentLanguage,
              onTap: onSubmitButtonTap),
    };
    return addVehicleStateWidgetMap[addVehicleStateValue] ??
        Text(AppLanguageTranslation.emptyTransKey.toCurrentLanguage);
  }
}
