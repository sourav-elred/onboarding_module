import 'dart:async';

import 'package:auth_module/features/onboarding/sign_up/constants/style_constants.dart';

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

class OTPview extends StatefulWidget {
  const OTPview({super.key});

  @override
  State<OTPview> createState() => _OTPviewState();
}

class _OTPviewState extends State<OTPview> {
  late Timer _timer;
  int _start = 60;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void restartTimer() {
    _start = 60;
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
                  style: StyleConstants.textStyle1,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Opacity(
                      opacity: 0.60,
                      child: Text(
                        'We have sent code to',
                        style: StyleConstants.textStyle1.copyWith(fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      context.read<SignUpViewModel>().phoneNumber,
                      style: StyleConstants.textStyle1.copyWith(fontSize: 14),
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
                Row(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    if (_timer.isActive) ...[
                      Text(
                        '00:$_start',
                        style: StyleConstants.textStyle1.copyWith(
                          color: const Color(0xFFBE212A),
                          fontSize: 14,
                        ),
                      )
                    ] else ...[
                      GestureDetector(
                        onTap: () {
                          context
                              .read<SignUpViewModel>()
                              .generateOTP(resentOTP: true)
                              .then((value) => restartTimer());
                        },
                        child: Text(
                          'Resend code',
                          style: StyleConstants.textStyle1.copyWith(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Consumer<SignUpViewModel>(
                      builder: (context, viewModel, child) {
                        if (viewModel.error != null) {
                          return Text(
                            viewModel.error!,
                            style: StyleConstants.textStyle1.copyWith(
                              color: const Color(0xFFE72D38),
                              fontSize: 12,
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
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
