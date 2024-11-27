class FakeIntroContent {
  String localSVGImageLocation;
  String slogan;
  String content;
  FakeIntroContent({
    this.localSVGImageLocation = '',
    this.slogan = '',
    this.content = '',
  });
}

class RecentSalesContent {
  String courseName;
  double price;
  RecentSalesContent({
    required this.courseName,
    required this.price,
  });
}
