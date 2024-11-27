import 'package:flutter/material.dart';
import 'package:one_ride_car_owner/utils/constants/app_colors.dart';
import 'package:one_ride_car_owner/utils/constants/app_gaps.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/core_widgets.dart';

class TransactionWidget extends StatelessWidget {
  final String transactionName;
  final DateTime date;
  final DateTime time;
  final double amount;
  final String transactionType;
  final String symbol;
  final bool isEarned;

  const TransactionWidget({
    super.key,
    required this.transactionType,
    required this.date,
    required this.time,
    required this.amount,
    required this.transactionName,
    required this.isEarned,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Center(
                child: isEarned
                    ? const SvgPictureAssetWidget(
                        AppAssetImages.solidAllowUpSVGLogoSolid)
                    : const SvgPictureAssetWidget(
                        AppAssetImages.solidAllowDownSVGLogoSolid)),
          ),
          AppGaps.wGap8,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactionName == 'add_money'
                    ? 'Top Up'
                    : transactionName == 'ride'
                        ? 'Ride Payment'
                        : transactionName == 'rent'
                            ? 'Rent Payment'
                            : 'Withdraw',
                style: AppTextStyles.bodyLargeMediumTextStyle,
              ),
              Text(
                '${Helper.ddMMMyyyyFormattedDateTime(date)}| ${Helper.hhMMaFormattedDate(time)}',
                style: AppTextStyles.bodyTextStyle
                    .copyWith(color: AppColors.bodyTextColor),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    symbol,
                    style: AppTextStyles.bodyLargeMediumTextStyle,
                  ),
                  AppGaps.wGap4,
                  Text(
                    amount.toString(),
                    style: AppTextStyles.bodyLargeMediumTextStyle,
                  ),
                ],
              ),
              Text(
                transactionType,
                style: AppTextStyles.bodyTextStyle
                    .copyWith(color: AppColors.bodyTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
