import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_car_owner/utils/constants/app_constants.dart';
import 'package:one_ride_car_owner/utils/constants/app_language_translations.dart';
import 'package:one_ride_car_owner/utils/constants/app_text_styles.dart';
import 'package:one_ride_car_owner/utils/extensions/string.dart';
import 'package:one_ride_car_owner/utils/helpers/helpers.dart';
import 'package:one_ride_car_owner/widgets/dotted_line.dart';
import 'package:shimmer/shimmer.dart';

/// Custom padded body widget for scaffold
class CustomScaffoldBodyWidget extends StatelessWidget {
  final Widget child;
  const CustomScaffoldBodyWidget({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppGaps.screenPaddingValue),
      child: child,
    );
  }
}

class ScaffoldBodyWidget extends StatelessWidget {
  final Widget child;
  final bool hasNoAppbar;
  const ScaffoldBodyWidget(
      {Key? key, required this.child, this.hasNoAppbar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasNoAppbar
        ? Padding(
            padding: AppComponents.screenHorizontalPadding,
            child: SafeArea(top: true, child: child),
          )
        : Padding(
            padding: AppComponents.screenHorizontalPadding,
            child: child,
          );
  }
}

/// Custom padded bottom bar widget for scaffold
class CustomScaffoldBottomBarWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  const CustomScaffoldBottomBarWidget(
      {Key? key, required this.child, this.backgroundColor, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppGaps.bottomNavBarPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

/// Minus, counter, plus buttons row for product cart counter.
class PlusMinusCounterRow extends StatelessWidget {
  final void Function()? onRemoveTap;
  final String counterText;
  final bool isDecrement;
  final void Function()? onAddTap;
  const PlusMinusCounterRow({
    Key? key,
    required this.onRemoveTap,
    required this.counterText,
    required this.isDecrement,
    required this.onAddTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RawButtonWidget(
            borderRadiusValue: 8,
            onTap: isDecrement ? onRemoveTap : null,
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                  color: Color(0xFFF4F5FA),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: SvgPictureAssetWidget(
                  AppAssetImages.minusSVGLogoSolid,
                  color: isDecrement
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
                  height: 5,
                  width: 5,
                ),
              ),
            ),
          ),
          AppGaps.wGap10,
          Expanded(
            child: Center(
              child: Text(
                counterText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.mainTextColor),
              ),
            ),
          ),
          AppGaps.wGap10,
          RawButtonWidget(
            borderRadiusValue: 8,
            onTap: onAddTap,
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                  color: AppColors.appBarIconTextColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: const Center(
                  child: SvgPictureAssetWidget(
                AppAssetImages.plusSVGLogoSolid,
                color: Colors.white,
                height: 20,
                width: 20,
              )),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretcheOutlinedButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomStretcheOutlinedButtonWidget({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                // elevation: 1000,
                // shadowColor: Colors.white,
                foregroundColor: AppColors.primaryColor,
                minimumSize: const Size(30, 62),
                shape: const RoundedRectangleBorder(
                    // side: BorderSide(color: Colors.black12),
                    borderRadius:
                        BorderRadius.all(AppComponents.defaultBorderRadius)),
              ),
              child: child),
        ),
      ],
    );
  }
}

// /// Custom TextButton stretches the width of the screen with small elevation
// /// shadow
// class CustomStretchedTextButtonWidget extends StatelessWidget {
//   final String buttonText;
//   final void Function()? onTap;
//   const CustomStretchedTextButtonWidget({
//     Key? key,
//     this.onTap,
//     required this.buttonText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: DecoratedBox(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 // color: AppColors.primaryColor.withOpacity(0.5),
//                 gradient: onTap == null
//                     ? LinearGradient(colors: [
//                         AppColors.primaryColor.withOpacity(0.5),
//                         AppColors.primaryColor.withOpacity(0.5)
//                       ])
//                     : LinearGradient(colors: [
//                         AppColors.primaryColor,
//                         AppColors.primaryColor.withOpacity(0.4),
//                       ])),
//             child: TextButton(
//                 onPressed: onTap,
//                 style: TextButton.styleFrom(
//                     elevation: onTap == null ? 0 : 10,
//                     // shadowColor: AppColors.primaryColor.withOpacity(0.25),
//                     primary: Colors.white,
//                     backgroundColor: onTap == null
//                         ? AppColors.primaryColor.withOpacity(0.15)
//                         : AppColors.primaryColor,
//                     minimumSize: const Size(30, 62),
//                     shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                             AppComponents.defaultBorderRadius))),
//                 child: Text(buttonText,
//                     style: onTap == null
//                         ? const TextStyle(color: Colors.white)
//                         : null)),
//           ),
//         ),
//       ],
//     );
//   }
// }

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow
class CustomStretchedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const CustomStretchedTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: onTap == null
                    ? AppColors.mainTextColor.withOpacity(0.5)
                    : AppColors.primaryColor
                /* gradient: onTap == null
                    ? LinearGradient(colors: [
                        AppColors.primaryColor,
                        Color.lerp(AppColors.primaryColor,
                                AppColors.primaryColor, 0.9) ??
                            AppColors.primaryColor.withOpacity(0.4),
                      ])
                    : LinearGradient(colors: [
                        AppColors.primaryColor,
                        Color.lerp(AppColors.primaryColor,
                                AppColors.primaryColor, 0.9) ??
                            AppColors.primaryColor.withOpacity(0.4),
                      ]) */
                ),
            child: TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    // elevation: onTap == null ? 0 : 00,
                    // shadowColor: AppColors.primaryColor.withOpacity(0.25),
                    // backgroundColor: onTap == null
                    //     ? AppColors.primaryColor.withOpacity(0.15)
                    //     : AppColors.primaryColor.withOpacity(0.0),
                    minimumSize: const Size(30, 62),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            AppComponents.defaultBorderRadius))),
                child: Text(buttonText,
                    textAlign: TextAlign.center,
                    style: onTap == null
                        ? const TextStyle(color: Colors.white)
                        : null)),
          ),
        ),
      ],
    );
  }
}

/// Custom TextButton with small elevation shadow
class CustomTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const CustomTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: onTap == null
              ? LinearGradient(colors: [
                  Color.lerp(AppColors.primaryColor, Colors.white, 0.5) ??
                      AppColors.primaryColor.withOpacity(0.5),
                  Color.lerp(AppColors.primaryColor, Colors.white, 0.5) ??
                      AppColors.primaryColor.withOpacity(0.5)
                ])
              : LinearGradient(colors: [
                  AppColors.primaryColor,
                  Color.lerp(AppColors.primaryColor, Colors.white, 0.4) ??
                      AppColors.primaryColor.withOpacity(0.4),
                ])),
      child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              elevation: onTap == null ? 0 : 10,
              shadowColor: AppColors.primaryColor.withOpacity(0.25),
              // backgroundColor: onTap == null
              //     ? AppColors.primaryColor.withOpacity(0.15)
              //     : AppColors.primaryColor.withOpacity(0.0),
              minimumSize: const Size(30, 62),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(AppComponents.defaultBorderRadius))),
          child: Text(buttonText,
              textAlign: TextAlign.center,
              style:
                  onTap == null ? const TextStyle(color: Colors.white) : null)),
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretchedButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomStretchedButtonWidget({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  elevation: 10,
                  shadowColor: AppColors.primaryColor.withOpacity(0.25),
                  backgroundColor: onTap == null
                      ? AppColors.primaryColor.withOpacity(0.5)
                      : AppColors.primaryColor,
                  minimumSize: const Size(30, 62),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(AppComponents.defaultBorderRadius))),
              child: child),
        ),
      ],
    );
  }
}

/// Custom toggle button of tab widget
class CustomTabToggleButtonWidget extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onTap;
  const CustomTabToggleButtonWidget(
      {Key? key, required this.isSelected, required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      animationDuration: Duration.zero,
      color: isSelected ? AppColors.primaryColor : Colors.transparent,
      elevation: isSelected ? 10 : 0,
      shadowColor: isSelected ? AppColors.primaryColor.withOpacity(0.25) : null,
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: isSelected ? Colors.white : null),
          ),
        ),
      ),
    );
  }
}
/* 
/// Minus, counter, plus buttons row for product cart counter.
class PlusMinusCounterRow extends StatelessWidget {
  final void Function()? onRemoveTap;
  final String counterText;
  final void Function()? onAddTap;
  const PlusMinusCounterRow({
    Key? key,
    required this.onRemoveTap,
    required this.counterText,
    required this.onAddTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomIconButtonWidget(
              backgroundColor: AppColors.shadeColor1,
              borderRadiusRadiusValue: const Radius.circular(6),
              fixedSize: const Size(24, 24),
              onTap: onRemoveTap,
              child: SvgPicture.asset(
                AppAssetImages.minusSVGLogoSolid,
                color: AppColors.bodyTextColor,
                height: 12,
                width: 12,
              )),
          AppGaps.wGap10,
          Expanded(
            child: Center(
              child: Text(
                counterText,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 12, color: AppColors.darkColor),
              ),
            ),
          ),
          AppGaps.wGap10,
          CustomIconButtonWidget(
              backgroundColor: AppColors.primaryColor,
              borderRadiusRadiusValue: const Radius.circular(6),
              fixedSize: const Size(24, 24),
              onTap: onAddTap,
              child: SvgPicture.asset(
                AppAssetImages.plusSVGLogoSolid,
                color: Colors.white,
                height: 12,
                width: 12,
              )),
        ],
      ),
    );
  }
} */
///Svg picture Insert

class SvgPictureAssetWidget extends StatelessWidget {
  final String assetName;
  final double? height;
  final double? width;
  final Color? color;
  final String? package;
  final BoxFit fit;
  const SvgPictureAssetWidget(this.assetName,
      {super.key,
      this.height,
      this.width,
      this.color,
      this.package,
      this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName,
        height: height,
        width: width,
        fit: fit,
        colorFilter:
            color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn));
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretchedOnlyTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const CustomStretchedOnlyTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                  minimumSize: const Size(30, 32),
                  visualDensity: const VisualDensity(),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(AppComponents.defaultBorderRadius))),
              child: Text(
                buttonText,
                style: const TextStyle(color: AppColors.mainTextColor),
              )),
        ),
      ],
    );
  }
}

/// Custom TextFormField configured with Theme.
class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isRequired;
  final bool isReadOnly;
  final FocusNode? focusNode;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const CustomTextFormField({
    Key? key,
    this.labelText,
    this.isRequired = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.focusNode,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      // height: (maxLines > 1 || (minLines ?? 1) > 1) ? null : 62,
      child: TextFormField(
        cursorColor: AppColors.mainTextColor,
        style: AppTextStyles.bodyLargeTextStyle
            .copyWith(color: AppColors.mainTextColor),
        focusNode: focusNode,
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        onChanged: onChanged,
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintStyle: AppTextStyles.bodyMediumTextStyle
              .copyWith(color: AppColors.mainTextColor),
          hintText: hintText,
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Row(
            children: [
              Text(labelText!,
                  style: AppTextStyles.bodyLargeMediumTextStyle
                      .copyWith(color: AppColors.mainTextColor)),
              if (isRequired)
                Text(
                  ' *',
                  style: AppTextStyles.bodySemiboldTextStyle
                      .copyWith(color: AppColors.alertColor),
                )
            ],
          ),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

class TightTextIconButtonWidget extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Widget iconWidget;
  final void Function()? onTap;
  const TightTextIconButtonWidget(
      {super.key,
      required this.text,
      required this.iconWidget,
      this.onTap,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomTightTextButtonWidget(
          onTap: onTap,
          child: Row(
            children: [
              AppGaps.wGap10,
              Text(
                text,
                style: textStyle,
              ),
              AppGaps.wGap10,
              iconWidget,
            ],
          ),
        )
      ],
    );
  }
}

/// Custom TextFormField configured with Theme.
class CustomMessageTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final double boxHeight;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const CustomMessageTextFormField({
    Key? key,
    this.labelText,
    this.boxHeight = 62,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      height: (maxLines > 1 || (minLines ?? 1) > 1) ? null : boxHeight,
      child: TextFormField(
        cursorColor: AppColors.mainTextColor,
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppColors.mainTextColor, width: 1)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppColors.mainTextColor, width: 1)),
          hintText: hintText,
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

class SearchFilterRowWidget extends StatelessWidget {
  final String? hintText;
  final bool isReadOnly;
  final bool showFilter;
  final TextEditingController? controller;
  final void Function()? onSearchTap;
  final void Function()? onFilterButtonTap;
  const SearchFilterRowWidget(
      {Key? key,
      this.hintText,
      this.isReadOnly = false,
      this.showFilter = false,
      this.controller,
      this.onSearchTap,
      this.onFilterButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SearchTextFormField(
              hintText: hintText,
              isReadOnly: isReadOnly,
              controller: controller,
              onTap: onSearchTap),
        ),
        showFilter == true ? AppGaps.wGap16 : AppGaps.emptyGap,
        if (showFilter)
          IconButtonWidget(
              fixedSize: const Size(51, 51),
              onTap: onFilterButtonTap,
              backgroundColor: AppColors.primaryColor,
              child: const LocalAssetSVGIcon(
                AppAssetImages.filterSVGLogoLine,
                color: Colors.white,
              ))
      ],
    );
  }
}

class StarWidget extends StatelessWidget {
  const StarWidget({
    super.key,
    required this.review,
  });

  final double review;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 20,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => AppGaps.wGap2,
          itemCount: 5,
          itemBuilder: (context, index) => SvgPicture.asset(
            AppAssetImages.starSVGLogoSolid,
            color: review >= (index + 1)
                ? AppColors.secondaryColor
                : AppColors.secondaryColor.withOpacity(0.3),
          ),
        ));
  }
}

class SingleStarWidget extends StatelessWidget {
  const SingleStarWidget({
    super.key,
    required this.review,
  });

  final double review;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SvgPictureAssetWidget(
          AppAssetImages.starSVGLogoSolid,
          height: 8,
          width: 8,
          color: AppColors.mainTextColor,
        ),
        AppGaps.wGap5,
        Text(
          '$review',
          style: AppTextStyles.smallestMediumTextStyle,
        )
      ],
    );
  }
}

class SearchTextFormField extends StatelessWidget {
  final String? hintText;
  final bool isReadOnly;
  final TextEditingController? controller;
  final void Function()? onTap;
  const SearchTextFormField(
      {super.key,
      this.hintText,
      this.isReadOnly = false,
      this.controller,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      isReadOnly: isReadOnly,
      controller: controller,
      onTap: onTap,
      prefixIcon: const LocalAssetSVGIcon(
        AppAssetImages.searchSVGLogoLine,
        color: AppColors.bodyTextColor,
      ),
      border: AppComponents.textFormFieldBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.primaryBorderColor)),
      hintText: hintText,
      hintTextStyle: AppTextStyles.hintTextStyle,
    );
  }
}

class SelectImageButton extends StatelessWidget {
  final void Function()? onTap;
  const SelectImageButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        borderRadiusValue: AppConstants.uploadImageButtonBorderRadiusValue,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(
                  AppConstants.uploadImageButtonBorderRadiusValue))),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(AppAssetImages.uploadSVGLogoLine,
                  color: AppColors.primaryColor, height: 40),
              AppGaps.hGap2,
              const Text('Tap here to upload images',
                  style: AppTextStyles.bodySemiboldTextStyle),
            ]),
          ),
        ));
  }
}

class MultiImageUploadWidget extends StatelessWidget {
  final List<String> imageURLs;
  final void Function()? onImageUploadTap;
  final void Function(int)? onImageTap;
  final void Function(int)? onImageEditTap;
  final void Function(int)? onImageDeleteTap;
  const MultiImageUploadWidget(
      {super.key,
      required this.imageURLs,
      this.onImageUploadTap,
      this.onImageEditTap,
      this.onImageDeleteTap,
      this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(18))),
      child: Builder(
          builder: (context) => imageURLs.isEmpty
              ? SelectImageButton(onTap: onImageUploadTap)
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == imageURLs.length) {
                      return SizedBox(
                          width: 180,
                          child: SelectImageButton(onTap: onImageUploadTap));
                    }
                    final imageURL = imageURLs[index];
                    return SizedBox(
                      width: 180,
                      child: SelectedNetworkImageWidget(
                        imageURL: imageURL,
                        onTap: onImageTap != null
                            ? () => onImageTap!(index)
                            : null,
                        onEditButtonTap: onImageEditTap != null
                            ? () => onImageEditTap!(index)
                            : null,
                        showDeleteButton: true,
                        onDeleteButtonTap: onImageDeleteTap != null
                            ? () => onImageDeleteTap!(index)
                            : null,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => AppGaps.wGap12,
                  itemCount: imageURLs.length + 1)),
    );
  }
}

class SelectedNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final void Function()? onTap;
  final void Function()? onEditButtonTap;
  final bool showDeleteButton;
  final void Function()? onDeleteButtonTap;

  const SelectedNetworkImageWidget({
    super.key,
    required this.imageURL,
    this.onTap,
    this.onEditButtonTap,
    this.onDeleteButtonTap,
    this.showDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 140,
      child: RawButtonWidget(
        borderRadiusValue: AppConstants.defaultBorderRadiusValue,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned.fill(
              child: CachedNetworkImageWidget(
                imageURL: imageURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: AppComponents.defaultBorder,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Builder(
                builder: (context) {
                  if (showDeleteButton) {
                    return Row(
                      children: [
                        TightIconButtonWidget(
                            icon: const LocalAssetSVGIcon(
                                AppAssetImages.uploadSVGLogoLine,
                                color: Colors.white),
                            onTap: onEditButtonTap),
                        AppGaps.wGap8,
                        TightIconButtonWidget(
                            icon: const LocalAssetSVGIcon(
                                AppAssetImages.uploadSVGLogoLine,
                                color: AppColors.alertColor),
                            onTap: onDeleteButtonTap),
                      ],
                    );
                  }
                  return TightIconButtonWidget(
                      icon: const LocalAssetSVGIcon(
                          AppAssetImages.uploadSVGLogoLine,
                          color: Colors.white),
                      onTap: onEditButtonTap);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//multiple image input
class MultiImageUploadSectionWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final List<String> imageURLs;
  final void Function()? onImageUploadTap;
  final void Function(int)? onImageTap;
  final void Function(int)? onImageEditTap;
  final void Function(int)? onImageDeleteTap;
  const MultiImageUploadSectionWidget({
    super.key,
    required this.label,
    this.isRequired = false,
    required this.imageURLs,
    this.onImageUploadTap,
    this.onImageEditTap,
    this.onImageDeleteTap,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.labelTextStyle,
            ),
            if (isRequired)
              Text(
                ' *',
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: AppColors.alertColor),
              )
          ],
        ),
        AppGaps.hGap16,
        MultiImageUploadWidget(
          imageURLs: imageURLs,
          onImageTap: onImageTap,
          onImageUploadTap: onImageUploadTap,
          onImageEditTap: onImageEditTap,
          onImageDeleteTap: onImageDeleteTap,
        ),
      ],
    );
  }
}

/// Custom TextFormField configured with Theme.
class LocationPickUpTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const LocationPickUpTextFormField({
    Key? key,
    this.focusNode,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      // height: (maxLines > 1 || (minLines ?? 1) > 1) ? null : 62,
      child: TextFormField(
        cursorColor: AppColors.mainTextColor,
        focusNode: focusNode,
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 25),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

/// Custom TextFormField configured with Theme.
class LocationPickDownTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const LocationPickDownTextFormField({
    Key? key,
    this.focusNode,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      // height: (maxLines > 1 || (minLines ?? 1) > 1) ? null : 62,
      child: TextFormField(
        cursorColor: AppColors.mainTextColor,
        focusNode: focusNode,
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18))),
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18))),
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 25),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap5,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

/// Radio widget without additional padding
class CustomRadioWidget extends StatelessWidget {
  final Object value;
  final Object? groupValue;
  final Function(Object?) onChanged;
  const CustomRadioWidget(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.mainTextColor)),
      child: Radio<Object>(
        activeColor: AppColors.mainTextColor,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}

/// Custom IconButton widget various attributes
class CustomIconButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Border? border;
  final Widget child;
  final Color backgroundColor;
  final Size fixedSize;
  final Radius borderRadiusRadiusValue;
  final bool isCircleShape;
  final bool hasShadow;
  const CustomIconButtonWidget(
      {Key? key,
      this.onTap,
      required this.child,
      this.backgroundColor = AppColors.appBarIconTextColor,
      this.fixedSize = const Size(40, 40),
      this.borderRadiusRadiusValue = const Radius.circular(14),
      this.border,
      this.isCircleShape = false,
      this.hasShadow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fixedSize.height,
      width: fixedSize.width,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          shape: isCircleShape ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
          border: border),
      child: Material(
        color: backgroundColor,
        shape: isCircleShape ? const CircleBorder() : null,
        shadowColor: hasShadow ? Colors.black.withOpacity(0.4) : null,
        elevation: hasShadow ? 8 : 0,
        borderRadius:
            isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
        child: InkWell(
          onTap: onTap,
          customBorder: isCircleShape ? const CircleBorder() : null,
          borderRadius: BorderRadius.all(borderRadiusRadiusValue),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/// Custom large text button widget
class CustomLargeTextButtonWidget extends StatelessWidget {
  final bool isSmallScreen;
  final void Function()? onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  const CustomLargeTextButtonWidget({
    Key? key,
    this.onTap,
    required this.text,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.isSmallScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            foregroundColor: textColor,
            fixedSize:
                isSmallScreen ? const Size(140, 55) : const Size(175, 65),
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            backgroundColor: backgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(AppComponents.defaultBorderRadius))),
        child: Text(text));
  }
}

/// Raw list tile does not have a background color
class CustomRawListTileWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final Radius? borderRadiusRadiusValue;
  const CustomRawListTileWidget({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadiusRadiusValue,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadiusRadiusValue != null
          ? BorderRadius.all(borderRadiusRadiusValue!)
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadiusRadiusValue != null
            ? BorderRadius.all(borderRadiusRadiusValue!)
            : null,
        child: child,
      ),
    );
  }
}

/// Custom list tile widget of white background color
class CustomListTileWidget extends StatelessWidget {
  final bool hasShadow;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final EdgeInsets paddingValue;
  final BorderRadius borderRadius;
  const CustomListTileWidget(
      {Key? key,
      required this.child,
      this.onTap,
      this.paddingValue = const EdgeInsets.all(AppGaps.screenPaddingValue),
      this.onLongPress,
      this.borderRadius =
          const BorderRadius.all(AppComponents.defaultBorderRadius),
      this.hasShadow = false,
      this.elevation = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: hasShadow ? elevation : 0,
      shadowColor: Colors.white.withOpacity(0.5),
      borderRadius: borderRadius,
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            alignment: Alignment.topLeft,
            padding: paddingValue,
            decoration: BoxDecoration(borderRadius: borderRadius),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Horizontal dashed line.
class CustomHorizontalDashedLineWidget extends StatelessWidget {
  const CustomHorizontalDashedLineWidget({
    Key? key,
    this.height = 1,
    this.color = Colors.black,
  }) : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Vertical dashed line
class CustomVerticalDashedLineWidget extends StatelessWidget {
  const CustomVerticalDashedLineWidget({
    Key? key,
    this.width = 1,
    this.color = Colors.black,
  }) : super(key: key);
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxHeight = constraints.constrainWidth();
        const dashHeight = 4.0;
        final dashWidth = width;
        final dashCount = (boxHeight / (2 * dashHeight)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Credit card widget with 3 shadows towards bottom
class PaymentCardWidget extends StatelessWidget {
  final Widget child;
  const PaymentCardWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 232,
      alignment: Alignment.topCenter,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(child: Container(alignment: Alignment.topCenter)),
          Container(
            height: 208,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 32, right: 32, top: 24),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          Container(
            height: 208,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          Container(
            height: 208,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: Image.asset(AppAssetImages.arrowDownSVGLogoLine,
                            cacheHeight: 163,
                            cacheWidth: 163,
                            height: 163,
                            width: 163)
                        .image,
                    alignment: Alignment.topRight)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

/// Slogan and subtitle text
class HighlightAndDetailTextWidget extends StatelessWidget {
  final String slogan;
  final String subtitle;
  final bool isSpaceShorter;
  final Color textColor; // New parameter for text color
  final Color subtextColor; // New parameter for text color

  const HighlightAndDetailTextWidget({
    Key? key,
    required this.slogan,
    required this.subtitle,
    this.isSpaceShorter = false,
    this.textColor = Colors.white, // Default text color is white
    this.subtextColor = Colors.white, // Default text color is white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(slogan,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleLargeBoldTextStyle
                .copyWith(color: textColor)),
        isSpaceShorter ? AppGaps.hGap8 : AppGaps.hGap16,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLargeTextStyle
                  .copyWith(color: subtextColor)),
        ),
      ],
    );
  }
}

class LoadingTextWidget extends StatelessWidget {
  final bool isSmall;
  const LoadingTextWidget({
    super.key,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSmall ? 15 : 20,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: AppComponents.smallBorderRadius),
      ),
    );
  }
}

/// Custom IconButton widget various attributes
class IconButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Border? border;
  final Widget child;
  final Color backgroundColor;
  final Size fixedSize;
  final Radius borderRadiusRadiusValue;
  final bool isCircleShape;
  final bool hasShadow;
  const IconButtonWidget(
      {Key? key,
      this.onTap,
      required this.child,
      this.backgroundColor = Colors.white,
      this.fixedSize = const Size(40, 40),
      this.borderRadiusRadiusValue = const Radius.circular(12),
      this.border,
      this.isCircleShape = false,
      this.hasShadow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fixedSize.height,
      width: fixedSize.width,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        shape: isCircleShape ? BoxShape.circle : BoxShape.rectangle,
        borderRadius:
            isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
        border: border ??
            Border.all(
                color: AppColors.appBarIconTextColor.withOpacity(0.4),
                width: 1.42),
      ),
      child: Material(
        color: backgroundColor,
        shape: isCircleShape ? const CircleBorder() : null,
        shadowColor: hasShadow ? Colors.black.withOpacity(0.4) : null,
        elevation: hasShadow ? 8 : 0,
        borderRadius:
            isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
        child: InkWell(
          onTap: onTap,
          customBorder: isCircleShape ? const CircleBorder() : null,
          borderRadius: BorderRadius.all(borderRadiusRadiusValue),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/// Custom TextButton widget which is very tight to child text
class CustomTightTextButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  const CustomTightTextButtonWidget({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity)),
        child: child);
  }
}

/// Custom grid item widget
class CustomGridSingleItemWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Color? borderColor;
  final BorderRadius borderRadius;
  final void Function()? onTap;
  const CustomGridSingleItemWidget({
    Key? key,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.padding = const EdgeInsets.all(7.5),
    required this.child,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              border:
                  borderColor != null ? Border.all(color: borderColor!) : null),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

/// This class contains functions that return a widget
class CoreWidgets1 {
  /// Custom app bar widget
  static AppBar appBarWidget(
      {required BuildContext screenContext,
      Widget? titleWidget,
      Widget? leading,
      List<Widget>? actions,
      bool hasBackButton = true}) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: hasBackButton
          ? Center(
              child: CustomIconButtonWidget(
                  onTap: () {
                    Get.back();
                  },
                  hasShadow: true,
                  child: SvgPicture.asset(
                    AppAssetImages.arrowLeftSVGLogoLine,
                    color: AppColors.darkColor,
                    height: 18,
                    width: 18,
                  )),
            )
          : leading,
      title: titleWidget,
      actions: actions,
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretchedOutlinedButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomStretchedOutlinedButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                // elevation: 1000,
                // shadowColor: Colors.white,
                side: const BorderSide(color: AppColors.mainTextColor),
                foregroundColor: AppColors.primaryColor,

                minimumSize: const Size(30, 62),

                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.mainTextColor),
                    borderRadius:
                        BorderRadius.all(AppComponents.defaultBorderRadius)),
              ),
              child: child),
        ),
      ],
    );
  }
}

class AlertDialogWidget extends StatelessWidget {
  final List<Widget>? actionWidgets;
  final Widget? contentWidget;
  final Widget? titleWidget;
  final Color? backgroundColor;
  const AlertDialogWidget({
    super.key,
    this.actionWidgets,
    this.contentWidget,
    this.titleWidget,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      titlePadding: AppComponents.dialogTitlePadding,
      contentPadding: AppComponents.dialogContentPadding,
      shape: const RoundedRectangleBorder(
          borderRadius: AppComponents.dialogBorderRadius),
      title: titleWidget,
      content: contentWidget,
      actions: actionWidgets,
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: AppComponents.dialogActionPadding,
      buttonPadding: EdgeInsets.zero,
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomDialogButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomDialogButtonWidget({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            elevation: 10,
            shadowColor: AppColors.primaryColor.withOpacity(0.25),
            backgroundColor: onTap == null
                ? AppColors.bodyTextColor
                : AppColors.primaryColor.withOpacity(0.7),
            minimumSize: const Size(128, 33),
            shape: const StadiumBorder(
                side: BorderSide(color: AppColors.mainTextColor))),
        child: child);
  }
}

class CustomStretchedOutlinedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Image? image;
  final Color? backgroundColor;
  final void Function()? onTap;

  const CustomStretchedOutlinedTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
    this.image, // Icon data parameter
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: backgroundColor,
              minimumSize: const Size(30, 62),
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(AppComponents.defaultBorderRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (image != null) // Conditionally include the image
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 8.0), // Adjust spacing as needed
                    child: image,
                  ),
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/* 
class CustomStretchedOutlinedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color? backgroundColor;
  final void Function()? onTap;
  final Image? image; // Add an Image field
  const CustomStretchedOutlinedTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
    this.backgroundColor,
    this.image, // Include the image as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (image != null) // Conditionally include the image
          Padding(
            padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
            child: image,
          ),
        Expanded(
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: backgroundColor,
              minimumSize: const Size(30, 62),
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(AppComponents.defaultBorderRadius),
              ),
            ),
            child: Text(buttonText, textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
} */

class NotificationDotWidget extends StatelessWidget {
  final bool isRead;
  const NotificationDotWidget({super.key, this.isRead = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isRead
              ? AppColors.darkColor.withOpacity(0.2)
              : AppColors.primaryColor,
          shape: BoxShape.circle),
    );
  }
}

class SwitchWidget extends StatelessWidget {
  final bool value;
  final void Function(bool) onToggle;
  const SwitchWidget({super.key, required this.value, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      value: value,
      width: 35,
      height: 20,
      toggleSize: 12,
      activeColor: AppColors.mainTextColor.withOpacity(0.5),
      onToggle: onToggle,
    );
  }
}

/// This class contains functions that return a widget
class CoreWidgets {
  /// Custom app bar widget
  static AppBar appBarWidget({
    required BuildContext screenContext,
    Widget? titleWidget,
    List<Widget>? actions,
    Widget? leading,
    bool hasBackButton = true,
    bool automaticallyImplyLeading = false,
  }) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: hasBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Center(
                child: CustomIconButtonWidget(
                    fixedSize: const Size(36, 36),
                    backgroundColor: AppColors.secondaryButtonFont,
                    onTap: () {
                      Get.back();
                    },
                    hasShadow: true,
                    child: const SvgPictureAssetWidget(
                      AppAssetImages.arrowLeftSVGLogoLine,
                      color: AppColors.mainTextColor,
                      height: 18,
                      width: 18,
                    )),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20),
              child: leading,
            ),
      title: titleWidget,
      titleTextStyle: AppTextStyles.titleBoldTextStyle
          .copyWith(color: AppColors.mainTextColor),
      actions: actions,
    );
  }

  static PagedChildBuilderDelegate<ItemType>
      pagedChildBuilderDelegate<ItemType>({
    required Widget Function(BuildContext, ItemType, int) itemBuilder,
    Widget Function(BuildContext)? errorIndicatorBuilder,
    Widget Function(BuildContext)? noItemFoundIndicatorBuilder,
    Widget Function(BuildContext)? firstPageLoadingIndicatorBuilder,
    Widget Function(BuildContext)? newPageLoadingIndicatorBuilder,
  }) {
    final firstPageProgressIndicatorBuilder =
        firstPageLoadingIndicatorBuilder ??
            (context) => const Center(child: CircularProgressIndicator());
    final newPageProgressIndicatorBuilder = newPageLoadingIndicatorBuilder ??
        (context) => const Center(child: CircularProgressIndicator());
    final pageErrorIndicatorBuilder =
        errorIndicatorBuilder ?? (context) => const ErrorPaginationWidget();
    final noItemsFoundIndicatorBuilder = noItemFoundIndicatorBuilder ??
        (context) => const ErrorPaginationWidget();
    return PagedChildBuilderDelegate<ItemType>(
        itemBuilder: itemBuilder,
        firstPageErrorIndicatorBuilder: pageErrorIndicatorBuilder,
        newPageErrorIndicatorBuilder: pageErrorIndicatorBuilder,
        noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
        firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder,
        newPageProgressIndicatorBuilder: newPageProgressIndicatorBuilder,
        animateTransitions: true,
        transitionDuration: const Duration(milliseconds: 200));
  }
}

class ErrorPaginationWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorPaginationWidget({
    Key? key,
    this.errorMessage = 'Error occurred while loading',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 150,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ErrorLoadedIconWidget(isLargeIcon: true),
            AppGaps.hGap5,
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMediumTextStyle,
            ),
          ],
        ));
  }
}

class ErrorLoadedIconWidget extends StatelessWidget {
  final bool isLargeIcon;
  const ErrorLoadedIconWidget({
    Key? key,
    this.isLargeIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Icon(Icons.error_outline,
            size: isLargeIcon ? 40 : null, color: AppColors.alertColor));
  }
}

/// Raw button widget
class RawButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final double? borderRadiusValue;
  final Color? backgroundColor;

  const RawButtonWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.borderRadiusValue,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: borderRadiusValue != null
          ? BorderRadius.all(Radius.circular(borderRadiusValue!))
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadiusValue != null
            ? BorderRadius.all(Radius.circular(borderRadiusValue!))
            : null,
        child: child,
      ),
    );
  }
}

/* class SelectImageButton extends StatelessWidget {
  final void Function()? onTap;
  const SelectImageButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        borderRadiusValue: Constants.uploadImageButtonBorderRadiusValue,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(
                  Constants.uploadImageButtonBorderRadiusValue))),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(AppAssetImages.uploadSVGLogoLine,
                  color: AppColors.primaryColor, height: 40),
              AppGaps.hGap2,
              const Text('abcd', style: AppTextStyles.bodySemiboldTextStyle),
            ]),
          ),
        ));
  }
} */
/* 
class SelectedNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final void Function()? onTap;
  final void Function()? onEditButtonTap;

  const SelectedNetworkImageWidget({
    super.key,
    required this.imageURL,
    this.onTap,
    this.onEditButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 140,
      child: RawButtonWidget(
        borderRadiusValue: Constants.defaultBorderRadiusValue,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned.fill(
              child: CachedNetworkImageWidget(
                imageURL: imageURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: AppComponents.defaultBorder,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: TightIconButtonWidget(
                  icon: const LocalAssetSVGIcon(AppAssetImages.editSVGLogoSolid,
                      color: Colors.white),
                  onTap: onEditButtonTap),
            )
          ],
        ),
      ),
    );
  }
} */

class SelectedLocalImageWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final List<String> imageURLs;
  final List<dynamic> imagesBytes;
  final void Function()? onTap;
  final void Function(int)? onImageDeleteTap;
  final void Function()? onImageUploadTap;

  const SelectedLocalImageWidget({
    super.key,
    required this.label,
    required this.imageURLs,
    this.isRequired = false,
    required this.imagesBytes,
    this.onTap,
    this.onImageDeleteTap,
    this.onImageUploadTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.labelTextStyle,
            ),
            if (isRequired)
              Text(
                ' *',
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: AppColors.alertColor),
              )
          ],
        ),
        AppGaps.hGap16,
        SizedBox(
          height: 140,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                // index += 1;
                if (index == imagesBytes.length) {
                  return SizedBox(
                      width: 180,
                      child: SelectImageButton(onTap: onImageUploadTap));
                }
                dynamic singleLocalImage = imagesBytes[index];
                return SizedBox(
                  width: 140,
                  height: 140,
                  child: RawButtonWidget(
                    borderRadiusValue: AppConstants.defaultBorderRadiusValue,
                    onTap: onTap,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: AppComponents.defaultBorder,
                                image: DecorationImage(
                                    image: (singleLocalImage is String)
                                        ? CachedNetworkImageProvider(
                                            singleLocalImage)
                                        : Image.memory(singleLocalImage).image,
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Row(
                            children: [
                              // const TightIconButtonWidget(
                              //     icon: LocalAssetSVGIcon(
                              //         AppAssetImages.emailFillSvgIcon,
                              //         color: Colors.white),
                              //     onTap: null),
                              // AppGaps.wGap10,
                              TightIconButtonWidget(
                                  icon: const LocalAssetSVGIcon(
                                      AppAssetImages.trashSVGLogoLine,
                                      color: AppColors.alertColor),
                                  onTap: onImageDeleteTap != null
                                      ? () => onImageDeleteTap!(index)
                                      : null),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              separatorBuilder: (context, index) => AppGaps.wGap10,
              itemCount: imagesBytes.length + 1),
        ),
      ],
    );
  }
}
// MultiImageUploadWidget(
//   imageURLs: imageURLs,
//   // onImageTap: onImageTap,
//   onImageUploadTap: onImageUploadTap,
//   // onImageEditTap: onImageEditTap,
//   // onImageDeleteTap: onImageDeleteTap,
// )

class LocalAssetSVGIcon extends StatelessWidget {
  final String iconLocalAssetLocation;
  final Color color;
  final double height;
  final double? width;
  const LocalAssetSVGIcon(this.iconLocalAssetLocation,
      {Key? key, required, required this.color, this.height = 24, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(iconLocalAssetLocation,
        height: height,
        width: width ?? height,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
  }
}

class DocumentLoadingImagePlaceholderWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String loadingAssetImageLocation;
  const DocumentLoadingImagePlaceholderWidget({
    super.key,
    this.height,
    this.width,
    this.loadingAssetImageLocation = AppAssetImages.imagePlaceholderIconImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: LoadingPlaceholderWidget(
          child: Image.asset(loadingAssetImageLocation)),
    );
  }
}

/// This icon button does not have any padding, margin around it
class TightIconButtonWidget extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  const TightIconButtonWidget({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        onPressed: onTap,
        icon: icon);
  }
}

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final BoxFit boxFit;
  final int? cacheHeight;
  final int? cacheWidth;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  const CachedNetworkImageWidget({
    Key? key,
    required this.imageURL,
    this.boxFit = BoxFit.cover,
    this.cacheHeight,
    this.cacheWidth,
    this.imageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageURL.isEmpty
        ? Image.asset(AppAssetImages.imagePlaceholderIconImage,
            fit: BoxFit.contain)
        : CachedNetworkImage(
            imageUrl: imageURL,
            placeholder: (context, url) =>
                const LoadingImagePlaceholderWidget(),
            errorWidget: (context, url, error) => const ErrorLoadedIconWidget(),
            imageBuilder: imageBuilder,
            memCacheHeight: cacheHeight,
            memCacheWidth: cacheWidth,
            fit: boxFit);
  }
}

class LoadingImagePlaceholderWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingImagePlaceholderWidget({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: LoadingPlaceholderWidget(
          child: Image.asset(AppAssetImages.imagePlaceholderIconImage)),
    );
  }
}

class LoadingPlaceholderWidget extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  const LoadingPlaceholderWidget({
    Key? key,
    required this.child,
    this.baseColor = AppColors.shimmerBaseColor,
    this.highlightColor = AppColors.shimmerHighlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: baseColor, highlightColor: highlightColor, child: child);
  }
}

class NoImageAvatarWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  const NoImageAvatarWidget({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: AppColors.primaryColor, shape: BoxShape.circle),
      child: Text(
        Helper.avatar2LetterUsername(firstName, lastName),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class IntrolightAndDetailTextWidget extends StatelessWidget {
  final String slogan;
  final String subtitle;
  final bool isSpaceShorter;
  const IntrolightAndDetailTextWidget({
    Key? key,
    required this.slogan,
    required this.subtitle,
    this.isSpaceShorter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          slogan,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: AppTextStyles.titleBoldTextStyle.copyWith(color: Colors.white),
        ),
        isSpaceShorter ? AppGaps.hGap8 : AppGaps.hGap16,
        Text(subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style:
                AppTextStyles.titleBoldTextStyle.copyWith(color: Colors.white)),
        AppGaps.hGap5,
      ],
    );
  }
}

/// Highlighted title, subtitle columned texts
class SloganTitleSubtitleTextColumnWidget extends StatelessWidget {
  const SloganTitleSubtitleTextColumnWidget({
    Key? key,
    required this.titleText,
    this.midTitleText = '',
    required this.subtitleText,
  }) : super(key: key);

  final String titleText;
  final String midTitleText;
  final String subtitleText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(titleText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleLargeBoldTextStyle
                          .copyWith(color: Colors.black)),
                  Text(midTitleText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleLargeBoldTextStyle
                          .copyWith(color: AppColors.primaryColor)),
                ],
              ),
              AppGaps.hGap16,
              Text(subtitleText,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyTextStyle
                      .copyWith(color: AppColors.primaryColor)),
            ],
          ),
        ),
      ],
    );
  }
}

/// Custom padded bottom bar widget for scaffold
class ScaffoldBottomBarWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  const ScaffoldBottomBarWidget(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.borderRadius,
      this.padding = AppGaps.bottomNavBarPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

/// Custom TextButton widget which is very tight to child text
class TightSmallTextButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final TextStyle textStyle;
  const TightSmallTextButtonWidget({
    Key? key,
    this.onTap,
    required this.text,
    this.textStyle = AppTextStyles.bodyMediumTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity)),
        child: Text(text, style: textStyle));
  }
}

// used for pick country code
class PhoneNumberTextFormFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final bool isRequired;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  final CountryCode? initialCountryCode;
  final bool isLabelWhiteText;
  final bool isFilled;
  final Color? fillColor;
  final void Function(CountryCode)? onCountryCodeChanged;
  const PhoneNumberTextFormFieldWidget({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.isRequired = false,
    this.initialCountryCode,
    this.onCountryCodeChanged,
    this.isLabelWhiteText = false,
    this.isFilled = false,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      labelText: labelText,
      prefixIconConstraints: const BoxConstraints(maxHeight: 32, maxWidth: 147),
      suffixIcon: suffixIcon,
      isPasswordTextField: isPasswordTextField,
      isReadOnly: isReadOnly,
      textInputType: TextInputType.phone,
      suffixIconConstraints: suffixIconConstraints,
      controller: controller,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      fillColor: fillColor,
      isLabelWhiteText: isLabelWhiteText,
      isRequired: isRequired,
      onTap: onTap,
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CountryCodePicker(
            favorite: ['+880', 'BDT'],

            closeIcon: const Icon(
              Icons.close,
              color: AppColors.mainTextColor,
            ),
            /* searchDecoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColors.mainTextColor),
                    borderRadius: BorderRadius.all(Radius.circular(15)))), */
            searchStyle: AppTextStyles.bodyMediumTextStyle
                .copyWith(color: AppColors.mainTextColor),
            boxDecoration: const BoxDecoration(color: AppColors.primaryColor),
            backgroundColor: AppColors.primaryColor,
            // enabled: false,
            initialSelection: initialCountryCode?.code,
            onChanged: onCountryCodeChanged,
            builder: (country) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 25,
                    child: Image.asset(country?.flagUri ?? '',
                        package: 'country_code_picker'),
                  ),
                  AppGaps.wGap8,
                  const SvgPictureAssetWidget(
                      AppAssetImages.arrowDownSVGLogoLine,
                      color: AppColors.mainTextColor),
                  AppGaps.wGap5,
                  Container(
                      height: 26, width: 2, color: AppColors.lineShapeColor),
                  AppGaps.wGap16,
                  Text(
                    country?.dialCode ?? '',
                    style: AppTextStyles.bodyTextStyle
                        .copyWith(color: AppColors.mainTextColor),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      hintText: hintText,
      hintTextStyle: AppTextStyles.bodyLargeTextStyle
          .copyWith(color: AppColors.mainTextColor),
    );
  }
}

/// Custom TextFormField configured with Theme.
class TextFormFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle hintTextStyle;
  final Widget? labelPrefixIcon;
  final bool isPasswordTextField;
  final bool isReadOnly;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final int? minLines;
  final int maxLines;
  final double suffixRightPaddingSize;
  final BoxConstraints prefixIconConstraints;
  final BoxConstraints suffixIconConstraints;
  final double prefixLeftPaddingSize;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool isFilled;
  final bool isLabelWhiteText;
  final bool isRequired;
  final Color? fillColor;
  final InputBorder? border;
  const TextFormFieldWidget({
    Key? key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.isPasswordTextField = false,
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.labelPrefixIcon,
    this.suffixRightPaddingSize = 24,
    this.hintTextStyle = AppTextStyles.bodyMediumTextStyle,
    this.prefixLeftPaddingSize = 24,
    this.validator,
    this.suffixIconConstraints = const BoxConstraints(maxHeight: 24),
    this.isFilled = true,
    this.fillColor,
    this.border,
    this.isLabelWhiteText = false,
    this.isRequired = false,
    this.prefixIconConstraints = const BoxConstraints(maxHeight: 24),
  }) : super(key: key);

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      // height: (maxLines > 1 || (minLines ?? 1) > 1) ? null : 56,
      child: TextFormField(
        cursorColor: AppColors.mainTextColor,
        style: AppTextStyles.bodyLargeTextStyle
            .copyWith(color: AppColors.mainTextColor),
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        obscuringCharacter: '*',
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        minLines: minLines,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.bodyMediumTextStyle
              .copyWith(color: AppColors.mainTextColor),
          border: border,
          enabledBorder: border,
          filled: isFilled,
          fillColor: fillColor,
          prefixIconConstraints: prefixIconConstraints,
          suffixIconConstraints: suffixIconConstraints,
          prefix: prefixIcon != null ? AppGaps.wGap16 : null,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: prefixLeftPaddingSize),
            child: prefixIcon ?? AppGaps.emptyGap,
          ),
          suffix: suffixIcon != null ? AppGaps.wGap16 : null,
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: suffixRightPaddingSize),
            child: suffixIcon ?? AppGaps.emptyGap,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelPrefixIcon != null
                  ? Container(
                      alignment: Alignment.topLeft,
                      constraints: const BoxConstraints(minHeight: 10),
                      child: labelPrefixIcon)
                  : AppGaps.emptyGap,
              labelPrefixIcon != null ? AppGaps.wGap15 : AppGaps.emptyGap,
              // Label text
              Expanded(
                child: Row(
                  children: [
                    Text(
                      labelText!,
                      style: AppTextStyles.bodyLargeMediumTextStyle.copyWith(
                          color: isLabelWhiteText
                              ? Colors.white
                              : AppColors.mainTextColor),
                    ),
                    if (isRequired)
                      Text(
                        ' *',
                        style: AppTextStyles.bodyLargeSemiboldTextStyle
                            .copyWith(color: AppColors.alertColor),
                      )
                  ],
                ),
              ),
            ],
          ),
          AppGaps.hGap8,
          // Text field
          textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return textFormFieldWidget();
    }
  }
}

class CheckboxWidget extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  const CheckboxWidget({super.key, this.value = false, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 19,
      height: 20,
      /* decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ), */
      child: Checkbox(value: value, onChanged: onChanged),
    );
  }
}

/// Custom list tile widget of white background color
class CustomMessageListTileWidget extends StatelessWidget {
  final bool hasShadow;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final EdgeInsets paddingValue;
  final BorderRadius borderRadius;
  const CustomMessageListTileWidget(
      {Key? key,
      required this.child,
      this.onTap,
      this.paddingValue =
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      this.onLongPress,
      this.borderRadius =
          const BorderRadius.all(AppComponents.defaultBorderRadius),
      this.hasShadow = false,
      this.elevation = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: hasShadow ? elevation : 0,
      shadowColor: Colors.grey.withOpacity(0.9),
      borderRadius: borderRadius,
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            alignment: Alignment.topLeft,
            padding: paddingValue,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: AppColors.primaryColor, width: 0.25)),
            child: child,
          ),
        ),
      ),
    );
  }
}

class EmptyScreenWidget extends StatelessWidget {
  final String localImageAssetURL;
  final bool isSVGImage;
  final String title;
  final String shortTitle;
  final double height;
  const EmptyScreenWidget({
    Key? key,
    required this.localImageAssetURL,
    required this.title,
    this.shortTitle = '',
    this.isSVGImage = false,
    this.height = 231,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height,
          //  width: 254,
          child: isSVGImage
              ? SvgPicture.asset(localImageAssetURL, height: 231)
              : Image.asset(
                  localImageAssetURL,
                  fit: BoxFit.contain,
                ),
        ),
        AppGaps.hGap32,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: AppTextStyles.titleBoldTextStyle,
              ),
              AppGaps.hGap8,
              Text(shortTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLargeTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}

/// Custom TextButton stretches the width of the screen
class StretchedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color color;
  final Color fontColor;
  final bool isSmallSizedButton;
  final void Function()? onTap;
  const StretchedTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
    this.backgroundColor = AppColors.primaryColor,
    this.color = AppColors.primaryBorderColor,
    this.fontColor = Colors.white,
    this.isSmallSizedButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonWidget(
              borderRadiusValue: 15,
              onTap: onTap,
              color: color,
              fixedSize: isSmallSizedButton ? null : const Size(211, 55),
              backgroundColor: onTap != null
                  ? backgroundColor
                  : backgroundColor.withOpacity(0.5),
              child: Text(
                buttonText,
                style: AppTextStyles.bodyLargeSemiboldTextStyle.copyWith(
                    color: onTap != null
                        ? fontColor
                        : AppColors.primaryColor.withOpacity(0.5)),
              )),
        ),
      ],
    );
  }
}

class DropdownButtonFormFieldWidget<T> extends StatelessWidget {
  final T? value;
  final String hintText;
  final Widget? prefixIcon;
  final bool isLoading;
  final String? labelText;
  final List<T>? items;
  final String Function(T)? getItemText;
  final BoxConstraints prefixIconConstraints;
  final Widget Function(T)? getItemChild;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final TextEditingController? controller;
  final bool isDense;
  const DropdownButtonFormFieldWidget(
      {super.key,
      this.value,
      required this.hintText,
      this.prefixIcon,
      this.items,
      this.getItemText,
      required this.onChanged,
      this.prefixIconConstraints =
          const BoxConstraints(maxHeight: 48, maxWidth: 48),
      this.labelText,
      this.validator,
      this.controller,
      this.isLoading = false,
      this.getItemChild,
      this.isDense = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: AppTextStyles.labelTextStyle
                .copyWith(color: AppColors.mainTextColor),
          ),
        if (labelText != null) AppGaps.hGap8,
        Builder(builder: (context) {
          if (isLoading) {
            return const DropdownButtonFormFieldLoadingWidget();
          }
          return DropdownButtonFormField<T>(
            dropdownColor: AppColors.primaryColor,
            style: AppTextStyles.bodyLargeMediumTextStyle
                .copyWith(color: AppColors.mainTextColor),
            isExpanded: true,
            isDense: isDense,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            value: value,
            borderRadius: AppComponents.defaultBorder,
            hint: Text(
              hintText,
              style: AppTextStyles.bodyLargeTextStyle
                  .copyWith(color: AppColors.mainTextColor),
            ),
            disabledHint: Text(hintText,
                style: AppTextStyles.labelTextStyle
                    .copyWith(color: AppColors.mainTextColor)),
            icon: /* LocalAssetSVGIcon(AppAssetImages.dropdownArrow,
                color: isDisabled()
                    ? AppColors.bodyTextColor.withOpacity(0.5)
                    : AppColors.bodyTextColor) */
                Icon(Icons.keyboard_arrow_down,
                    color: isDisabled()
                        ? AppColors.bodyTextColor.withOpacity(0.5)
                        : AppColors.bodyTextColor),
            // iconEnabledColor: AppColors.bodyTextColor,
            // iconDisabledColor: AppColors.lineShapeColor,
            decoration: InputDecoration(
                prefixIconConstraints: prefixIconConstraints,
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: prefixIcon,
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
            items: items
                ?.map((e) =>
                    DropdownMenuItem(value: e, child: _getItemChildWidget(e)))
                .toList(),
            onChanged: onChanged,
          );
        }),
      ],
    );
  }

  Widget _getItemChildWidget(T element) {
    if (getItemChild != null) {
      return getItemChild!(element);
    }
    if (getItemText != null) {
      return Text(getItemText!(element));
    }
    return AppGaps.emptyGap;
  }

  bool isDisabled() =>
      onChanged == null || (items == null || (items?.isEmpty ?? true));
}

class HorizontalListViewBuilderWidget extends StatelessWidget {
  final double listViewHeight;
  final bool hasLeftPadding;
  final bool reverse;
  final Widget separatorBuilderWidget;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  const HorizontalListViewBuilderWidget({
    Key? key,
    required this.listViewHeight,
    this.hasLeftPadding = false,
    this.reverse = false,
    required this.separatorBuilderWidget,
    required this.itemBuilder,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listViewHeight,
      child: ListView.separated(
        reverse: reverse,
        padding: _getListViewPadding(hasLeftPadding),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => separatorBuilderWidget,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }

  EdgeInsets _getListViewPadding(bool hasLeftPadding) {
    return hasLeftPadding
        ? const EdgeInsets.symmetric(
            horizontal: AppConstants.screenPaddingValue)
        : const EdgeInsets.only(
            right: AppConstants.screenPaddingValue,
            left: AppConstants.screenPaddingValue,
          );
  }
}

class DropdownButtonFormFieldLoadingWidget extends StatelessWidget {
  const DropdownButtonFormFieldLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: AppComponents.defaultBorder,
            border: Border.all(width: 2)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 120, child: LoadingTextWidget()),
              Spacer(),
              Icon(Icons.keyboard_arrow_down, color: AppColors.bodyTextColor)
            ],
          ),
        ),
      ),
    );
  }
}

class DottedHorizontalLine extends StatelessWidget {
  final Color? dashColor;
  final double dashLength;
  final double dashGapLength;
  const DottedHorizontalLine({
    Key? key,
    this.dashColor,
    this.dashLength = 4,
    this.dashGapLength = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      lineThickness: 1.5,
      dashColor: dashColor ?? AppColors.primaryColor.withOpacity(0.5),
      dashLength: dashLength,
      dashGapLength: dashGapLength,
      dashRadius: 50,
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Color color;
  final Color backgroundColor;
  final Widget child;
  final Size? fixedSize;
  final double borderRadiusValue;

  const ButtonWidget({
    Key? key,
    this.onTap,
    this.color = Colors.white,
    this.backgroundColor = AppColors.primaryColor,
    required this.child,
    this.fixedSize,
    this.borderRadiusValue = AppConstants.borderRadiusValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: color,
          disabledForegroundColor: Colors.white,
          disabledBackgroundColor: AppColors.lightGreyColor,
          backgroundColor: backgroundColor,
          minimumSize: const Size(30, 44),
          fixedSize: fixedSize,
          shape: RoundedRectangleBorder(
              borderRadius:
                  // BorderRadius.all(Radius.circular(Constants.borderRadiusValue)),
                  AppConstants.borderRadius(borderRadiusValue)),
        ),
        child: child);
  }
}

class EnrollPaymentButtonLoadingWidget extends StatelessWidget {
  const EnrollPaymentButtonLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: StretchedTextButtonWidget(
          buttonText: AppLanguageTranslation.loadingTransKey.toCurrentLanguage),
    );
  }
}

class PerformancePercentageWidget extends StatelessWidget {
  final Color circleColor;
  final String status;
  final int percentage;
  const PerformancePercentageWidget({
    super.key,
    this.circleColor = AppColors.primaryColor,
    required this.status,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 13,
              width: 13,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: circleColor),
            ),
            AppGaps.wGap10,
            Text(status)
          ],
        ),
        Text('$percentage')
      ],
    );
  }
}
