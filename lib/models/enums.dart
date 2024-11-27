import 'package:one_ride_car_owner/utils/constants/app_constants.dart';

enum MyOrderTabState { pending, delivered, cancelled }

enum AddVehicleTabState { step1, step2, step3 }

enum AddVehicleTabStateStatus { step1, step2, step3 }

enum AddVehicleDetailsTabState { incomplete, current, completed }

/* <-------- Enums for various screens --------> */

enum ResetPasswordSelectedChoice {
  none,
  mail,
  phoneNumber,
}

enum PasswordStrongLevel {
  none,
  error,
  weak,
  normal,
  strong,
  veryStrong,
}

enum VehicleDetailsInfoTypeStatus {
  specifications(AppConstants.vehicleDetailsInfoTypeStatusSpecifications,
      'Specifications'),
  features(AppConstants.vehicleDetailsInfoTypeStatusFeatures, 'Features'),
  documents(AppConstants.vehicleDetailsInfoTypeStatusDocuments, 'Documents');

  final String stringValue;
  final String stringValueForView;
  const VehicleDetailsInfoTypeStatus(this.stringValue, this.stringValueForView);

  static VehicleDetailsInfoTypeStatus toEnumValue(String value) {
    final Map<String, VehicleDetailsInfoTypeStatus> stringToEnumMap = {
      VehicleDetailsInfoTypeStatus.specifications.stringValue:
          VehicleDetailsInfoTypeStatus.specifications,
      VehicleDetailsInfoTypeStatus.features.stringValue:
          VehicleDetailsInfoTypeStatus.features,
      VehicleDetailsInfoTypeStatus.documents.stringValue:
          VehicleDetailsInfoTypeStatus.documents,
    };
    return stringToEnumMap[value] ??
        VehicleDetailsInfoTypeStatus.specifications;
  }
}

enum MessageTypeStatus {
  customer(AppConstants.messageTypeStatusCustomer, 'Customer'),
  owner(AppConstants.messageTypeStatusCustomer, 'Owner'),
  driver(AppConstants.messageTypeStatusDriver, 'Driver'),
  admin(AppConstants.messageTypeStatusAdmin, 'Admin');

  final String stringValue;
  final String stringValueForView;
  const MessageTypeStatus(this.stringValue, this.stringValueForView);

  static MessageTypeStatus toEnumValue(String value) {
    final Map<String, MessageTypeStatus> stringToEnumMap = {
      MessageTypeStatus.customer.stringValue: MessageTypeStatus.customer,
      MessageTypeStatus.owner.stringValue: MessageTypeStatus.owner,
      MessageTypeStatus.driver.stringValue: MessageTypeStatus.driver,
      MessageTypeStatus.admin.stringValue: MessageTypeStatus.admin,
    };
    return stringToEnumMap[value] ?? MessageTypeStatus.customer;
  }
}

enum VehicleListStatus {
  pending(AppConstants.vehicleListEnumPending, 'Pending'),
  approved(AppConstants.vehicleListEnumApproved, 'Approved'),
  cancelled(AppConstants.vehicleListEnumCancelled, 'Cancelled'),
  suspended(AppConstants.vehicleListEnumSuspended, 'Suspended');

  final String stringValue;
  final String stringValueForView;
  const VehicleListStatus(this.stringValue, this.stringValueForView);

  static VehicleListStatus toEnumValue(String value) {
    final Map<String, VehicleListStatus> stringToEnumMap = {
      VehicleListStatus.pending.stringValue: VehicleListStatus.pending,
      VehicleListStatus.approved.stringValue: VehicleListStatus.approved,
      VehicleListStatus.cancelled.stringValue: VehicleListStatus.cancelled,
      VehicleListStatus.suspended.stringValue: VehicleListStatus.suspended,
    };
    return stringToEnumMap[value] ?? VehicleListStatus.pending;
  }
}

enum RideDriverTabStatus {
  accepted(AppConstants.hireDriverListEnumAccept, 'Accepted'),
  started(AppConstants.hireDriverListEnumStarted, 'Started'),
  userPending(AppConstants.hireDriverListEnumUserPending, 'User Pending'),
  driverPending(AppConstants.hireDriverListEnumDriverPending, 'Driver Pending'),
  completed(AppConstants.hireDriverListEnumComplete, 'Completed'),
  cancelled(AppConstants.hireDriverListEnumCancel, 'Cancelled');

  final String stringValue;
  final String stringValueForView;
  const RideDriverTabStatus(this.stringValue, this.stringValueForView);

  static RideDriverTabStatus toEnumValue(String value) {
    final Map<String, RideDriverTabStatus> stringToEnumMap = {
      RideDriverTabStatus.accepted.stringValue: RideDriverTabStatus.accepted,
      RideDriverTabStatus.started.stringValue: RideDriverTabStatus.started,
      RideDriverTabStatus.userPending.stringValue:
          RideDriverTabStatus.userPending,
      RideDriverTabStatus.driverPending.stringValue:
          RideDriverTabStatus.driverPending,
      RideDriverTabStatus.completed.stringValue: RideDriverTabStatus.completed,
      RideDriverTabStatus.cancelled.stringValue: RideDriverTabStatus.cancelled,
    };
    return stringToEnumMap[value] ?? RideDriverTabStatus.driverPending;
  }
}

enum TabStatus {
  accepted(AppConstants.hireDriverListEnumAccept, 'Upcomming'),
  started(AppConstants.hireDriverListEnumStarted, 'Started'),
  completed(AppConstants.hireDriverListEnumComplete, 'Completed'),
  cancelled(AppConstants.hireDriverListEnumCancel, 'Cancelled');

  final String stringValue;
  final String stringValueForView;
  const TabStatus(this.stringValue, this.stringValueForView);

  static TabStatus toEnumValue(String value) {
    final Map<String, TabStatus> stringToEnumMap = {
      TabStatus.accepted.stringValue: TabStatus.accepted,
      TabStatus.started.stringValue: TabStatus.started,
      TabStatus.completed.stringValue: TabStatus.completed,
      TabStatus.cancelled.stringValue: TabStatus.cancelled,
    };
    return stringToEnumMap[value] ?? TabStatus.accepted;
  }
}

enum LanguageSetting { english, russian, french, canada, australian, german }

enum CountrySetting { usa, russian, french, canada, australian, german }

enum CurrencySetting { usa, russian, bdt, canada, australian, german }

enum HomeScreenStatus { offline, online, orderList, currentOrderDetails }

enum OrderStatus {
  pending(AppConstants.orderStatusPending, 'Pending'),
  accepted(AppConstants.orderStatusAccepted, 'Accepted'),
  rejected(AppConstants.orderStatusRejected, 'Rejected'),
  picked(AppConstants.orderStatusPicked, 'Picked'),
  onWay(AppConstants.orderStatusOnWay, 'On the way'),
  delivered(AppConstants.orderStatusDelivered, 'Delivered'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String viewableText;
  const OrderStatus(this.stringValue, this.viewableText);

  static OrderStatus toEnumValue(String value) {
    final Map<String, OrderStatus> stringToEnumMap = {
      OrderStatus.pending.stringValue: OrderStatus.pending,
      OrderStatus.accepted.stringValue: OrderStatus.accepted,
      OrderStatus.rejected.stringValue: OrderStatus.rejected,
      OrderStatus.picked.stringValue: OrderStatus.picked,
      OrderStatus.onWay.stringValue: OrderStatus.onWay,
      OrderStatus.delivered.stringValue: OrderStatus.delivered,
      OrderStatus.unknown.stringValue: OrderStatus.unknown,
    };
    return stringToEnumMap[value] ?? OrderStatus.unknown;
  }
}

enum ConfirmedOrderNotificationType {
  confirmOrder(AppConstants.confirmedOrderNotifyTypeConfirmOrder),
  unknown(AppConstants.unknown);

  final String stringValue;
  const ConfirmedOrderNotificationType(this.stringValue);

  static ConfirmedOrderNotificationType toEnumValue(String value) {
    final Map<String, ConfirmedOrderNotificationType> stringToEnumMap = {
      ConfirmedOrderNotificationType.confirmOrder.stringValue:
          ConfirmedOrderNotificationType.confirmOrder,
      ConfirmedOrderNotificationType.unknown.stringValue:
          ConfirmedOrderNotificationType.unknown,
    };
    return stringToEnumMap[value] ?? ConfirmedOrderNotificationType.unknown;
  }
}

enum PaymentMethodName {
  cashOnDelivery(AppConstants.paymentMethodCashOnDelivery, 'Cash on delivery'),
  stripe(AppConstants.paymentMethodStripe, 'Stripe'),
  paypal(AppConstants.paymentMethodPaypal, 'Paypal'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String viewableText;
  const PaymentMethodName(this.stringValue, this.viewableText);

  static PaymentMethodName toEnumValue(String value) {
    final Map<String, PaymentMethodName> stringToEnumMap = {
      PaymentMethodName.cashOnDelivery.stringValue:
          PaymentMethodName.cashOnDelivery,
      PaymentMethodName.stripe.stringValue: PaymentMethodName.stripe,
      PaymentMethodName.paypal.stringValue: PaymentMethodName.paypal,
      PaymentMethodName.unknown.stringValue: PaymentMethodName.unknown,
    };
    return stringToEnumMap[value] ?? PaymentMethodName.unknown;
  }
}

enum HireDriverStatus {
  hourly(AppConstants.hireDriverStatusHourly, 'Hourly'),
  fixed(AppConstants.hireDriverStatusFixed, 'Fixed');

  final String stringValue;
  final String viewableText;
  const HireDriverStatus(this.stringValue, this.viewableText);

  static HireDriverStatus toEnumValue(String value) {
    final Map<String, HireDriverStatus> stringToEnumMap = {
      HireDriverStatus.hourly.stringValue: HireDriverStatus.hourly,
      HireDriverStatus.fixed.stringValue: HireDriverStatus.fixed,
    };
    return stringToEnumMap[value] ?? HireDriverStatus.hourly;
  }
}
