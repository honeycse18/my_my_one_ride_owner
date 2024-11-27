class FakeChatMessageModel {
  bool isMyMessage;
  String message;
  String dateTimeText;
  FakeChatMessageModel({
    this.isMyMessage = false,
    this.message = '',
    this.dateTimeText = '',
  });
}

class FakeHireDriverList {
  String image;
  String driverName;
  String about;
  int experience;
  int rideNumber;
  double rate;
  FakeHireDriverList({
    this.image = '',
    this.driverName = '',
    this.about = '',
    this.experience = 0,
    this.rideNumber = 0,
    this.rate = 0,
  });
}

class FakeCancelRideReason {
  String reasonName;
  FakeCancelRideReason({
    this.reasonName = '',
  });
}

class FakeNotificationModel {
  String timeText;
  bool isRead;
  List<FakeNotificationTextModel> texts;
  FakeNotificationModel({
    required this.timeText,
    required this.isRead,
    required this.texts,
  });
}

class FakeNotificationTextModel {
  String text;
  bool isHashText;
  bool isColoredText;
  bool isBoldText;
  FakeNotificationTextModel({
    required this.text,
    this.isHashText = false,
    this.isColoredText = false,
    this.isBoldText = false,
  });
}
