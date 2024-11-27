class SubmitReviewScreenParameter {
  String id;
  String type;
  SubmitReviewScreenParameter({required this.id, required this.type});
}

class SelectPaymentOptionModel {
  String viewAbleName;
  String value;
  String paymentImage;
  SelectPaymentOptionModel({
    this.viewAbleName = '',
    this.value = '',
    this.paymentImage = '',
  });
}
