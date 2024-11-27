// import 'fake_models/bid_category_model.dart';

import 'package:one_ride_car_owner/models/fakeModel/chat_message_model.dart';
import 'package:one_ride_car_owner/models/fakeModel/intro_content_model.dart';
import 'package:one_ride_car_owner/models/fakeModel/payment_option_model.dart';
import 'package:one_ride_car_owner/models/fakeModel/submit_review_screen_parameter.dart';

class FakeData {
  // Intro screens
  static List<FakeIntroContent> fakeIntroContents = [
    FakeIntroContent(
        localSVGImageLocation: 'assets/images/intro1.png',
        slogan: 'Book your car',
        content:
            'Sell houses easily with the help of Listenoryx and to make this line big I am writing mores.'),
    FakeIntroContent(
        localSVGImageLocation: 'assets/images/intro2.png',
        slogan: 'At anytime',
        content:
            'Sell houses easily with the help of Listenoryx and to make this line big I am writing more'),
    FakeIntroContent(
        localSVGImageLocation: 'assets/images/intro3.png',
        slogan: 'Anywhere You are',
        content:
            'Sell houses easily with the help of Listenoryx and to make this line big I am writing more'),
  ];

  static List<RecentSalesContent> recentSales = [
    RecentSalesContent(
      courseName: 'JavaScript for Beginners',
      price: 90,
    ),
    RecentSalesContent(
      courseName: 'Flutter for Beginners',
      price: 200.50,
    ),
    RecentSalesContent(
      courseName: 'C++ for Beginners',
      price: 225.5,
    ),
    RecentSalesContent(
      courseName: 'Dart for Beginners',
      price: 50.6,
    )
  ];
  static List<FakePaymentOptionModel> paymentOptions = [
    /* FakePaymentOptionModel(
        id: '1',
        name: 'Cash',
        paymentImage:
            'https://seeklogo.com/images/C/cash-app-logo-A39DD086EB-seeklogo.com.png'), */
    FakePaymentOptionModel(
        id: '2',
        name: 'paypal',
        paymentImage:
            'https://w1.pngwing.com/pngs/138/644/png-transparent-paypal-logo-text-line-blue.png'),
    /*   FakePaymentOptionModel(
        id: '3',
        name: 'Move to Money',
        paymentImage:
            'https://togocom.tg/wp-content/uploads/2020/08/Logo_TMoney_Togocom_New1.png'),
    FakePaymentOptionModel(
        id: '4',
        name: 'Bank',
        paymentImage:
            'https://togocom.tg/wp-content/uploads/2020/08/Logo_TMoney_Togocom_New1.png'), */
  ];
  static var paymentOptionList = <SelectPaymentOptionModel>[
    SelectPaymentOptionModel(
        paymentImage:
            'https://icons.iconarchive.com/icons/flat-icons.com/flat/512/Wallet-icon.png',
        value: 'wallet',
        viewAbleName: 'Wallet'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/8808/8808875.png',
        value: 'cash',
        viewAbleName: 'Cash'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/174/174861.png',
        value: 'paypal',
        viewAbleName: 'PayPal'),
  ];
  static var subPaymentOptionList = <SelectPaymentOptionModel>[
    /* SelectPaymentOptionModel(
        paymentImage:
            'https://icons.iconarchive.com/icons/flat-icons.com/flat/512/Wallet-icon.png',
        value: 'wallet',
        viewAbleName: 'Wallet'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/8808/8808875.png',
        value: 'cash',
        viewAbleName: 'Cash'), */
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/174/174861.png',
        value: 'paypal',
        viewAbleName: 'PayPal'),
  ];

  /// Sample delivery man chat data
  static List<FakeChatMessageModel> chatMessages = [
    FakeChatMessageModel(
      isMyMessage: true,
      message: 'Hey there?\nHow much time?',
      dateTimeText: '11:59 am',
    ),
    FakeChatMessageModel(
      isMyMessage: false,
      message: 'On my way sir.\nWill reach in 10 mins.',
      dateTimeText: '11:59 am',
    ),
    FakeChatMessageModel(
      isMyMessage: true,
      message: 'Ok come with carefully!\nRemember the address please!',
      dateTimeText: '11:59 am',
    ),
    FakeChatMessageModel(
      isMyMessage: false,
      message:
          'Btw, I want to know more about the room space and facilities & can I get some more picture of current.',
      dateTimeText: 'Sep 04 2020',
    ),
  ];

  static var cancelRideReason = <FakeCancelRideReason>[
    FakeCancelRideReason(reasonName: 'Waiting for a long time '),
    FakeCancelRideReason(reasonName: 'Ride isn\'t here '),
    FakeCancelRideReason(reasonName: 'Wrong address shown'),
    FakeCancelRideReason(reasonName: 'Don\'t charge rider'),
    FakeCancelRideReason(reasonName: 'Other'),
  ];

  /// Sample delivery man chat data
  static List<FakeHireDriverList> hireDriverList = [
    FakeHireDriverList(
        driverName: 'Mugaid Papo',
        experience: 10,
        image:
            'https://i.pinimg.com/originals/f5/fa/e7/f5fae71f0ebb589514b66f593811851d.png',
        rate: 340000,
        about:
            'A driver is an individual responsible for operating a motor vehicle, with the main objective of transporting passengers or goods from one place to another. Whether driving a taxi, delivery truck, or a personal car, drivers play a critical role in keeping',
        rideNumber: 100),
    FakeHireDriverList(
        driverName: 'Rahul jems',
        experience: 45,
        rate: 34,
        about:
            'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
        image: 'https://img.freepik.com/free-photo/man-white_1368-3544.jpg',
        rideNumber: 500),
    FakeHireDriverList(
        driverName: 'Dipto cap',
        experience: 20,
        rate: 24,
        about:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
        image:
            'https://freepngimg.com/download/man/22850-7-man-transparent-image.png',
        rideNumber: 300),
    FakeHireDriverList(
        driverName: 'Ting Papo',
        experience: 1,
        rate: 54,
        about:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        image:
            'https://thumbs.dreamstime.com/z/handsome-muscular-black-man-full-length-white-background-urban-modern-style-orange-tank-top-blacks-trousers-shoes-png-69569227.jpg',
        rideNumber: 50),
    FakeHireDriverList(
        driverName: 'kiron tikki',
        experience: 5,
        rate: 64,
        image:
            'https://img.lovepik.com/free-png/20220120/lovepik-business-man-likes-png-image_401513074_wh300.png',
        rideNumber: 200),
  ];
}
