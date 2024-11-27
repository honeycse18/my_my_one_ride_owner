import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/controller/menu_bar_screen/image_zoom_screen_controller.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class ImageZoomScreen extends StatelessWidget {
  const  ImageZoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = Helper.getScreenSize(context);
    return GetBuilder<ImageZoomScreenController>(
        init: ImageZoomScreenController(),
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              appBar: CoreWidgets.appBarWidget(screenContext: context),
              body: SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: InteractiveViewer(
                    maxScale: 4,
                    child: Image.network(
                      controller.imageURL,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : const DocumentLoadingImagePlaceholderWidget(
                                  loadingAssetImageLocation:
                                      AppAssetImages.imagePlaceholderIconImage),
                      frameBuilder: (context, child, frame,
                              wasSynchronouslyLoaded) =>
                          wasSynchronouslyLoaded
                              ? child
                              : AnimatedOpacity(
                                  opacity: frame == null ? 0 : 1,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOut,
                                  child: child,
                                ),
                      errorBuilder: (context, error, stackTrace) =>
                          const ErrorLoadedIconWidget(isLargeIcon: true),
                    )),
              ),
            ));
  }
}
