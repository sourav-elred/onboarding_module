import '../../constants/style_constants.dart';
import 'package:flutter/material.dart';

class TermsAndPolicyText extends StatelessWidget {
  const TermsAndPolicyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'By proceeding you agree to',
          style: StyleConstants.textStyle1.copyWith(
            color: const Color(0xFF5F5F5F),
            fontSize: 13,
          ),
        ),
        Text(
          'Terms of services and Privacy Policies',
          style: StyleConstants.textStyle1.copyWith(
            color: const Color(0xFF5F5F5F),
            fontSize: 13,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
