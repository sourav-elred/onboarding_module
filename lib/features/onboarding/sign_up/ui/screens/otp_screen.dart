import '../../../../../core/ui/widgets/app_bar/api_loader_screen.dart';
import '../../../../../core/ui/widgets/app_bar/app_bar_widget.dart';
import '../widgets/custom_otp_field.dart';
import '../../../../../core/ui/widgets/custom_red_button.dart';
import '../../view_models/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const OTPview(),
        Selector<SignUpViewModel, bool>(
          builder: (_, isLoading, child) => Visibility(
            visible: isLoading,
            child: const ApiLoaderScreen(),
          ),
          selector: (_, model) => model.isLoading,
        ),
      ],
    );
  }
}

class OTPview extends StatelessWidget {
  const OTPview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        appBarTitle: "One Time Password-OTP",
        isLeadingButton: true,
        leadingWidth: 70,
        transformValue: 20,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 37),
                const Text(
                  'Enter code sent to your number',
                  style: TextStyle(
                    color: Color(0xFF302F2F),
                    fontSize: 34,
                    fontFamily: 'Avenir Next LT Pro',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Opacity(
                      opacity: 0.60,
                      child: Text(
                        'We have sent code to',
                        style: TextStyle(
                          color: Color(0xFF302F2F),
                          fontSize: 14,
                          fontFamily: 'Avenir Next LT Pro',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      context.read<SignUpViewModel>().phoneNumber,
                      style: const TextStyle(
                        color: Color(0xFF302F2F),
                        fontSize: 14,
                        fontFamily: 'Avenir Next LT Pro',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 32),
                OtpFieldWidget(
                  onChange: (value) {
                    context.read<SignUpViewModel>().onOTPChange(value);
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Resend code',
                  style: TextStyle(
                    color: Color(0xFF5F5F5F),
                    fontSize: 14,
                    fontFamily: 'Avenir Next LT Pro',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    height: 1.50,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Selector<SignUpViewModel, bool>(
              selector: (ctx, viewModel) => viewModel.otp.length >= 6,
              builder: (context, shouldEnable, child) => CustomRedButton(
                labelText: 'Let’s get started',
                onTap: !shouldEnable
                    ? null
                    : () => context.read<SignUpViewModel>().verifyOTP(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
