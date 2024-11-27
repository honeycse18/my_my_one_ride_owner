import 'package:one_ride_car_owner/models/location_model.dart';

class SelectLocationScreenParameters {
  String? screenTitle;
  bool? showCurrentLocationButton;
  LocationModel? locationModel;
  SelectLocationScreenParameters(
      {this.screenTitle, this.showCurrentLocationButton, this.locationModel});
}
class SubsCriptionScreenParameters {
  String? id;
  String? type;
  SubsCriptionScreenParameters(
      {this.id, this.type});
}
