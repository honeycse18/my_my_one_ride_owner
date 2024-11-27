import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_car_owner/models/fakeModel/chat_message_model.dart';
import 'package:one_ride_car_owner/models/fakeModel/fake_data.dart';

class CancelReasonRideBottomSheetController extends GetxController {
  int selectedReasonIndex = -1;
  TextEditingController otherReasonTextController = TextEditingController();
  FakeCancelRideReason selectedCancelReason = FakeCancelRideReason();

  onSubmitButtonTap() {
    String reason = selectedCancelReason.reasonName == 'Other'
        ? otherReasonTextController.text
        : FakeData.cancelRideReason[selectedReasonIndex].reasonName;

    Get.back(result: reason);
  }
}
