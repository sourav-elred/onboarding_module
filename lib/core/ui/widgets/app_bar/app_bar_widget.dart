import 'app_bar_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String? appBarTitle;
  final Widget? actionButton;
  final Color? bgColor;
  final bool isIosButton;
  final bool isLeadingButton;
  final double? elevation;
  final double? transformValue;
  final double? leadingWidth;
  final TextStyle? textStyle;

  final VoidCallback? onLeadingButtonPressed;
  const AppBarWidget(
      {Key? key,
      this.appBarTitle,
      this.isLeadingButton = false,
      this.onLeadingButtonPressed,
      this.isIosButton = false,
      this.actionButton,
      this.elevation,
      this.bgColor,
      this.transformValue,
      this.leadingWidth,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: bgColor ?? Colors.transparent),
      shadowColor: const Color(0xff001E8A).withOpacity(0.8),
      title: appBarTitle != null
          ? Transform(
              transform:
                  Matrix4.translationValues(-(transformValue ?? 0.0), 0.0, 0.0),
              child: Text(
                appBarTitle!,
                style: textStyle ??
                    const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 19 / 16,
                      fontFamily: 'WorkSans',
                    ),
              ),
            )
          : null,
      elevation: elevation ?? 0.0,
      leadingWidth: leadingWidth ?? (isLeadingButton ? 60 : 0),
      backgroundColor: bgColor ?? Colors.transparent,
      leading: !isLeadingButton
          ? const SizedBox.shrink()
          : AppBarLeadingIcon(
              isIosButton: true,
              onTap:
                  onLeadingButtonPressed ?? () => Navigator.of(context).pop(),
              disableAutoPop: true,
            ),
      actions: [if (actionButton != null) actionButton!],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 44);
}
