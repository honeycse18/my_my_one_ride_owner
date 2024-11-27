import 'package:one_ride_car_owner/utils/constants/app_constants.dart';

class HomeGraphData {
  final DateTime date;
  final int rideCount;
  final int rentCount;
  HomeGraphData({
    required this.date,
    this.rideCount = 0,
    this.rentCount = 0,
  });

  factory HomeGraphData.empty() =>
      HomeGraphData(date: AppComponents.defaultUnsetDateTime);
}
