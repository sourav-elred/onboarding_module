import '../../../../../core/ui/widgets/app_bar/api_loader_screen.dart';
import '../../../../../core/ui/widgets/app_bar/app_bar_widget.dart';
import '../../../../../core/ui/widgets/custom_red_button.dart';
import '../widgets/intl_phone_number_input_widget.dart';
import '../widgets/terms_and_policy.dart';
import '../../view_models/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpWithPhoneScreen extends StatelessWidget {
  const SignUpWithPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SignUpView(),
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

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        isLeadingButton: Navigator.of(context).canPop(),
        transformValue: Navigator.of(context).canPop() ? 20 : -5,
        appBarTitle: "Sign up / Sign In",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 37),
                const Text(
                  'Enter your personal mobile number',
                  style: TextStyle(
                    color: Color(0xFF302F2F),
                    fontSize: 34,
                    fontFamily: 'Avenir Next LT Pro',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 14),
                const Opacity(
                  opacity: 0.60,
                  child: Text(
                    'We will send you a confirmation code',
                    style: TextStyle(
                      color: Color(0xFF302F2F),
                      fontSize: 14,
                      fontFamily: 'Avenir Next LT Pro',
                      fontWeight: FontWeight.w500,
                      height: 1.50,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                IntlPhoneNumberInputWidget(
                  onInputChanged: (phoneNumber) {
                    if (phoneNumber.phoneNumber != null) {
                      context
                          .read<SignUpViewModel>()
                          .onPhoneNumberChange(phoneNumber.phoneNumber!);
                    }
                  },
                ),
                const Divider(color: Color(0xff797979)),
                const SizedBox(
                  width: 309,
                  child: Text(
                    'Personal number please',
                    style: TextStyle(
                      color: Color(0xFF5F5F5F),
                      fontSize: 12,
                      fontFamily: 'Avenir Next LT Pro',
                      fontWeight: FontWeight.w500,
                      height: 2.25,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  const Text(
                    'Request OTP on your registered email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE72D38),
                      fontSize: 14,
                      fontFamily: 'Avenir Next LT Pro',
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Selector<SignUpViewModel, bool>(
                    selector: (ctx, viewModel) {
                      if (viewModel.phoneNumber.length != 13) {
                        return false;
                      } else {
                        return true;
                      }
                    },
                    builder: (context, isValid, child) => CustomRedButton(
                      labelText: 'Continue',
                      onTap: !isValid
                          ? null
                          : () => context.read<SignUpViewModel>().generateOTP(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TermsAndPolicyText(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
