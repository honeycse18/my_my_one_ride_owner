import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/models/api_responses/dashboard_response.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';

class YourPieChartComponent extends StatelessWidget {
  final DashboardInfoVehicle selectedCar;

  const YourPieChartComponent(this.selectedCar);

  @override
  Widget build(BuildContext context) {
    // Implement your pie chart using the selected car's data
    // Use selectedCar.stats for pie chart data
    return Container(
      // Your pie chart implementation here...
      child: Text(
          '${AppLanguageTranslation.pieChartForTransKey.toCurrentLanguage} ${selectedCar.vehicle.name}'),
    );
  }
}
