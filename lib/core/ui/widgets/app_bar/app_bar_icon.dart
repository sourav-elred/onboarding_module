import 'package:flutter/material.dart';

class AppBarLeadingIcon extends StatelessWidget {
  final Color iconColor;
  final Function? onTap;
  final bool isIosButton;
  final bool disableAutoPop;
  const AppBarLeadingIcon(
      {Key? key,
      this.iconColor = Colors.black,
      this.onTap,
      this.disableAutoPop = false,
      this.isIosButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: SizedBox(
          height: 40,
          width: 40,
          child: Icon(
            isIosButton ? Icons.arrow_back_ios : Icons.arrow_back,
            color: iconColor,
            size: 22,
          ),
        ));
  }
}
