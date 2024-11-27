import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:one_ride_car_owner/screens/add_ride_vehicle_screen.dart';
import 'package:one_ride_car_owner/screens/all_transaction_screen.dart';
import 'package:one_ride_car_owner/screens/change_password_screen.dart';
import 'package:one_ride_car_owner/screens/create_new_password_screen.dart';
import 'package:one_ride_car_owner/screens/delete_account.dart';
import 'package:one_ride_car_owner/screens/email_login_screen.dart';
import 'package:one_ride_car_owner/screens/fleet_management/add_fuel_screen.dart';
import 'package:one_ride_car_owner/screens/fleet_management/add_maintainance_screen.dart';
import 'package:one_ride_car_owner/screens/fleet_management/fleet_management_screen.dart';
import 'package:one_ride_car_owner/screens/fleet_management/fuel_management_list_screen.dart';
import 'package:one_ride_car_owner/screens/fleet_management/maintenance_screen.dart';
import 'package:one_ride_car_owner/screens/hire_driver_start_screen.dart';
import 'package:one_ride_car_owner/screens/history_rent_details.dart';
import 'package:one_ride_car_owner/screens/home_navigator_screens/add_hire_driver_screen.dart';
import 'package:one_ride_car_owner/screens/home_navigator_screens/contact_us_.dart';
import 'package:one_ride_car_owner/screens/home_navigator_screens/help_support_screen.dart';
import 'package:one_ride_car_owner/screens/home_navigator_screens/hire_driver_screen.dart';
import 'package:one_ride_car_owner/screens/home_navigator_screens/subscription_screen.dart';
import 'package:one_ride_car_owner/screens/home_navigator_screens/zoom_drawer_screen.dart';
import 'package:one_ride_car_owner/screens/image_zoom.dart';
import 'package:one_ride_car_owner/screens/intro_screen.dart';
import 'package:one_ride_car_owner/screens/login_password_screen.dart';
import 'package:one_ride_car_owner/screens/login_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/about_us_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/add_rent_management_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/add_vehicle_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/admin_chat_screen_details.dart';
import 'package:one_ride_car_owner/screens/menu_screens/chat_screen_details.dart';
import 'package:one_ride_car_owner/screens/menu_screens/driver_details_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/driver_management_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/fleet_permission.dart';
import 'package:one_ride_car_owner/screens/menu_screens/hire_driver_details_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/hired_driver_details_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/languagescreen/language_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/message_list_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/privacy_policy_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/profile_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/rent_ride_management_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/terms_and_condition_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/vehicle_details_information_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/vehicle_details_screen.dart';
import 'package:one_ride_car_owner/screens/menu_screens/vehicle_screen.dart';
import 'package:one_ride_car_owner/screens/my_subscriptions_screen.dart';
import 'package:one_ride_car_owner/screens/notification_screen.dart';
import 'package:one_ride_car_owner/screens/password_change_success_screen.dart';
import 'package:one_ride_car_owner/screens/password_recovery_select_screen.dart';
import 'package:one_ride_car_owner/screens/select_location_screen.dart';
import 'package:one_ride_car_owner/screens/select_payment_methods_screen_hire_driver.dart';
import 'package:one_ride_car_owner/screens/select_payment_methods_screen_subscription.dart';
import 'package:one_ride_car_owner/screens/settings_screen.dart';
import 'package:one_ride_car_owner/screens/sign_up_screen.dart';
import 'package:one_ride_car_owner/screens/splash_screen.dart';
import 'package:one_ride_car_owner/screens/unknown_screen.dart';
import 'package:one_ride_car_owner/screens/verification_screen.dart';
import 'package:one_ride_car_owner/screens/wallet_screens/topup_screen.dart';
import 'package:one_ride_car_owner/utils/constants/app_page_names.dart';

class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(name: AppPageNames.rootScreen, page: () => const SplashScreen()),
    GetPage(
        name: AppPageNames.selectLocation,
        page: () => const SelectLocationScreen()),
    GetPage(name: AppPageNames.introScreen, page: () => const IntroScreen()),
    GetPage(name: AppPageNames.logInScreen, page: () => const LoginScreen()),
    GetPage(
        name: AppPageNames.logInPasswordScreen,
        page: () => const LogInPasswordScreen()),
    GetPage(
        name: AppPageNames.emailLogInScreen,
        page: () => const EmailLoginScreen()),
    GetPage(
        name: AppPageNames.verificationScreen,
        page: () => const VerificationScreen()),
    GetPage(
        name: AppPageNames.registrationScreen,
        page: () => const RegistrationScreen()),
    GetPage(
        name: AppPageNames.allTransactionScreen,
        page: () => const AllTransactionScreen()),
    GetPage(
        name: AppPageNames.passwordRecoveryScreen,
        page: () => const PasswordRecoverySelectScreen()),
    GetPage(name: AppPageNames.topupScreen, page: () => const TopUpScreen()),
    GetPage(
        name: AppPageNames.createNewPasswordScreen,
        page: () => const CreateNewPasswordScreen()),
    GetPage(
        name: AppPageNames.zoomDrawerScreen,
        page: () => const ZoomDrawerScreen()),
         GetPage(
        name: AppPageNames.deleteAccount, page: () => const DeleteAccount()),
    GetPage(
        name: AppPageNames.passwordChangedScreen,
        page: () => const PasswordChangSuccessScreen()),
    GetPage(
        name: AppPageNames.zoomDrawerScreen,
        page: () => const ZoomDrawerScreen()),
    GetPage(
        name: AppPageNames.privacyPolicyScreen,
        page: () => const PrivacyPolicyScreen()),
    GetPage(
      name: AppPageNames.termsConditionScreen,
      page: () => const TermsConditionScreen(),
    ),
    GetPage(
      name: AppPageNames.contactUsScreen,
      page: () => const ContactUsScreen(),
    ),
    GetPage(
      name: AppPageNames.addVehicleScreen,
      page: () => const AddVehicleScreen(),
    ),
    GetPage(
      name: AppPageNames.chatScreen,
      page: () => const ChatScreen(),
    ),
    GetPage(
      name: AppPageNames.imageZoomScreen,
      page: () => const ImageZoomScreen(),
    ),
    GetPage(
      name: AppPageNames.vehicleDetailsInformationScreen,
      page: () => const VehicleDetailsInformationScreen(),
    ),
    GetPage(
      name: AppPageNames.vehicleDetailsScreen,
      page: () => const VehicleDetailsScreen(),
    ),
    GetPage(
      name: AppPageNames.hireDriverDetailsScreen,
      page: () => const HireDriverDetailsScreen(),
    ),
    GetPage(
      name: AppPageNames.hiredDriverDetailsScreen,
      page: () => const HiredDriverDetailsScreen(),
    ),
    GetPage(
        name: AppPageNames.hireDriverStartScreen,
        page: () => const HireDriverStartScreen()),
    GetPage(
      name: AppPageNames.fleetPermissionDriverScreen,
      page: () => const FleetPermissionDriverScreen(),
    ),
    GetPage(
      name: AppPageNames.fleetManagementScreen,
      page: () => const FleetManagementScreen(),
    ),
    GetPage(
      name: AppPageNames.languageScreen,
      page: () => const LanguageScreen(),
    ),
    GetPage(
      name: AppPageNames.driverDetailsScreen,
      page: () => const DriverDetailsScreen(),
    ),
    GetPage(
      name: AppPageNames.notificationScreen,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: AppPageNames.adminChatScreen,
      page: () => const AdminChatScreen(),
    ),
    GetPage(
      name: AppPageNames.addRentScreen,
      page: () => const AddRentScreen(),
    ),
    GetPage(
      name: AppPageNames.addRideScreen,
      page: () => const AddRideScreen(),
    ),
    GetPage(
        name: AppPageNames.settingsScreen, page: () => const SettingsScreen()),
    GetPage(
      name: AppPageNames.addFuelScreen,
      page: () => const AddFuelScreen(),
    ),
    GetPage(
      name: AppPageNames.fuelManagementListScreen,
      page: () => const FuelManagementListScreen(),
    ),
    GetPage(
        name: AppPageNames.hireDriverSelectPaymentMethodsScreen,
        page: () => const HireDriverSelectPaymentMethodsScreen()),
    GetPage(
      name: AppPageNames.addHireDriverScreen,
      page: () => const AddHireDriverScreen(),
    ),
    GetPage(
      name: AppPageNames.maintananceScreen,
      page: () => const MaintenanceScreen(),
    ),
    GetPage(
      name: AppPageNames.addMaintenenceScreen,
      page: () => const AddMaintenanceScreen(),
    ),
    GetPage(
      name: AppPageNames.historyRentDetails,
      page: () => const HistoryRentDetailsScreen(),
    ),
    GetPage(
      name: AppPageNames.myAccountScreen,
      page: () => const MyAccountScreen(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 300),
      name: AppPageNames.helpSupportScreen,
      page: () => const HelpSupportScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 300),
      name: AppPageNames.messageListScreen,
      page: () => const MessageListScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 300),
      name: AppPageNames.aboutUsScreen,
      page: () => const AboutUsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 300),
      name: AppPageNames.vehicleScreen,
      page: () => const VehicleScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 300),
      name: AppPageNames.rentRideScreen,
      page: () => const RentRideManagementScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
        name: AppPageNames.changePasswordPromptScreen,
        page: () => const ChangePasswordPromptScreen()),
    GetPage(
        name: AppPageNames.subscriptionPaymentMethodsScreen,
        page: () => const SubscriptionPaymentMethodsScreen()),
    GetPage(
      transitionDuration: const Duration(milliseconds: 300),
      name: AppPageNames.subscriptionScreen,
      page: () => const SubscriptionScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    /*  GetPage(
      transitionDuration: const Duration(milliseconds: 300),
      name: AppPageNames.upgradeSubscriptionScreen,
      page: () => const UpgradeSubscriptionScreen(),
      transition: Transition.fade,
    ), */
    GetPage(
      transitionDuration: const Duration(milliseconds: 300),
      name: AppPageNames.driverManagementScreen,
      page: () => const DriverManagementScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 300),
      name: AppPageNames.hireDriverScreen,
      page: () => const HireDriverScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 300),
      name: AppPageNames.mySubscriptionsScreen,
      page: () => const MySubscriptionsScreen(),
      transition: Transition.fade,
    ),
  ];
  static final GetPage<dynamic> unknownScreenPageRoute = GetPage(
      name: AppPageNames.unknownScreen, page: () => const UnknownScreen());
}
