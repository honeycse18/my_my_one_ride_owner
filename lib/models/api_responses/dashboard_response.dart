import 'package:one_ride_car_owner/utils/constants/app_components.dart';
import 'package:one_ride_car_owner/utils/helpers/api_helper.dart';

class DashboardResponse {
  bool error;
  String msg;
  DashboardInfo data;

  DashboardResponse({this.error = false, this.msg = '', required this.data});

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: DashboardInfo.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory DashboardResponse.empty() => DashboardResponse(data: DashboardInfo());

  static DashboardResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashboardResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DashboardResponse.empty();
}

class DashboardInfo {
  String id;
  Map<String, dynamic> rides;
  Map<String, dynamic> rents;
  List<DashboardInfoVehicle> vehicles;
  int fuel;
  int maintenance;

  DashboardInfo(
      {this.id = '',
      this.fuel = 0,
      this.maintenance = 0,
      this.rides = const {},
      this.rents = const {},
      this.vehicles = const []});

  factory DashboardInfo.fromJson(Map<String, dynamic> json) => DashboardInfo(
        id: APIHelper.getSafeStringValue(json['_id']),
        fuel: APIHelper.getSafeIntValue(json['fuel']),
        maintenance: APIHelper.getSafeIntValue(json['maintenance']),
        rides: APIHelper.isAPIResponseObjectSafe(json['rides'])
            ? json['rides']
            : {},
        rents: APIHelper.isAPIResponseObjectSafe(json['rents'])
            ? json['rents']
            : {},
        vehicles: (APIHelper.getSafeListValue(json['vehicles']))
            .map((e) => DashboardInfoVehicle.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'fuel': fuel,
        'maintenance': maintenance,
        'rides': rides,
        'rents': rents,
        'vehicles': vehicles.map((e) => e.toJson()).toList(),
      };

  static DashboardInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashboardInfo.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : DashboardInfo();

  List<DashboardInfoRide> get ridesAsObjects {
    final List<DashboardInfoRide> data = [];
    rides.forEach((key, value) {
      data.add(DashboardInfoRide(
          date: DateTime.tryParse(key) ?? AppComponents.defaultUnsetDateTime,
          rideCount: value));
    });
    return data;
  }

  List<DashboardInfoRent> get rentsAsObjects {
    final List<DashboardInfoRent> data = [];
    rents.forEach((key, value) {
      data.add(DashboardInfoRent(
          date: DateTime.tryParse(key) ?? AppComponents.defaultUnsetDateTime,
          rentCount: value));
    });
    return data;
  }
}

class DashboardInfoRide {
  final DateTime date;
  final int rideCount;
  DashboardInfoRide({
    required this.date,
    required this.rideCount,
  });
}

class DashboardInfoRent {
  final DateTime date;
  final int rentCount;
  DashboardInfoRent({
    required this.date,
    required this.rentCount,
  });
}

class DashboardInfoVehicle {
  String id;
  DashboardInfoVehicleDetails vehicle;
  String type;
  DashboardInfoVehicleStats stats;

  DashboardInfoVehicle(
      {this.id = '',
      required this.vehicle,
      this.type = '',
      required this.stats});

  factory DashboardInfoVehicle.fromJson(Map<String, dynamic> json) =>
      DashboardInfoVehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        vehicle: DashboardInfoVehicleDetails.getAPIResponseObjectSafeValue(
            json['vehicle']),
        type: APIHelper.getSafeStringValue(json['type']),
        stats: DashboardInfoVehicleStats.getAPIResponseObjectSafeValue(
            json['stats']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
        'type': type,
        'stats': stats.toJson(),
      };
  factory DashboardInfoVehicle.empty() => DashboardInfoVehicle(
      vehicle: DashboardInfoVehicleDetails(),
      stats: DashboardInfoVehicleStats());

  static DashboardInfoVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashboardInfoVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DashboardInfoVehicle.empty();
}

class DashboardInfoVehicleStats {
  int cancelled;
  int completed;
  int accepted;

  DashboardInfoVehicleStats(
      {this.cancelled = 0, this.completed = 0, this.accepted = 0});

  factory DashboardInfoVehicleStats.fromJson(Map<String, dynamic> json) =>
      DashboardInfoVehicleStats(
        cancelled: APIHelper.getSafeIntValue(json['cancelled']),
        completed: APIHelper.getSafeIntValue(json['completed']),
        accepted: APIHelper.getSafeIntValue(json['accepted']),
      );

  Map<String, dynamic> toJson() => {
        'cancelled': cancelled,
        'completed': completed,
        'accepted': accepted,
      };

  static DashboardInfoVehicleStats getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashboardInfoVehicleStats.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DashboardInfoVehicleStats();

  int get total => cancelled + completed + accepted;

  double get cancelledPercentage {
    try {
      final value = (cancelled / total) * 100;
      if (value.isNaN) {
        return 0;
      }
      if (value.isInfinite) {
        return 0;
      }
      return value;
    } catch (e) {
      return 0;
    }
  }

  double get completedPercentage {
    try {
      final value = (completed / total) * 100;
      if (value.isNaN) {
        return 0;
      }
      if (value.isInfinite) {
        return 0;
      }
      return value;
    } catch (e) {
      return 0;
    }
  }

  double get acceptedPercentage {
    try {
      final value = (accepted / total) * 100;
      if (value.isNaN) {
        return 0;
      }
      if (value.isInfinite) {
        return 0;
      }
      return value;
    } catch (e) {
      return 0;
    }
  }

  double get cancelledPiePercentage {
    try {
      final value = (cancelled / total) * 360;
      if (value.isNaN) {
        return 0;
      }
      if (value.isInfinite) {
        return 0;
      }
      return value;
    } catch (e) {
      return 0;
    }
  }

  double get completedPiePercentage {
    try {
      final value = (completed / total) * 360;
      if (value.isNaN) {
        return 0;
      }
      if (value.isInfinite) {
        return 0;
      }
      return value;
    } catch (e) {
      return 0;
    }
  }

  double get acceptedPiePercentage {
    try {
      final value = (accepted / total) * 360;
      if (value.isNaN) {
        return 0;
      }
      if (value.isInfinite) {
        return 0;
      }
      return value;
    } catch (e) {
      return 0;
    }
  }
}

class DashboardInfoVehicleDetails {
  String id;
  String uid;
  String name;

  DashboardInfoVehicleDetails({this.id = '', this.uid = '', this.name = ''});

  factory DashboardInfoVehicleDetails.fromJson(Map<String, dynamic> json) =>
      DashboardInfoVehicleDetails(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
      };

  static DashboardInfoVehicleDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashboardInfoVehicleDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DashboardInfoVehicleDetails();
}
