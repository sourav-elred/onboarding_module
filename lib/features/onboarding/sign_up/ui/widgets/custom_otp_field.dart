import '../../constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class OtpFieldWidget extends StatelessWidget {
  const OtpFieldWidget({super.key, this.onChange});

  final Function(String value)? onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          length: 6,
          separatorBuilder: (index) => const SizedBox(
            width: 19,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          defaultPinTheme: PinTheme(
              textStyle: StyleConstants.textStyle2,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              )),
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          onChanged: onChange,
          cursor: Container(
            margin: const EdgeInsets.only(bottom: 9),
            height: 22,
            width: 1,
            color: Colors.black,
          ),
          focusedPinTheme: PinTheme(
            textStyle: StyleConstants.textStyle2,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
          submittedPinTheme: PinTheme(
            textStyle: StyleConstants.textStyle2,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
          errorPinTheme: const PinTheme(
            textStyle: StyleConstants.textStyle2,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xffBE212A)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
