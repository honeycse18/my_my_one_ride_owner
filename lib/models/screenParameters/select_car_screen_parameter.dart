import 'package:one_ride_car_owner/models/location_model.dart';

class SelectCarScreenParameter {
  LocationModel pickupLocation;
  LocationModel dropLocation;
  SelectCarScreenParameter(
      {required this.pickupLocation, required this.dropLocation});
}
