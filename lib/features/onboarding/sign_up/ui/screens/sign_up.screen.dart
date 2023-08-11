import 'package:auth_module/core/ui/widgets/widget_with_loader.dart';
import 'package:auth_module/core/utlis/mixins/notifier_mixin.dart';
import 'package:auth_module/features/onboarding/sign_up/constants/style_constants.dart';

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
    // return Stack(
    //   children: [
    //     const SignUpView(),
    //     Selector<SignUpViewModel, bool>(
    //       builder: (_, isLoading, child) => Visibility(
    //         visible: isLoading,
    //         child: const ApiLoaderScreen(),
    //       ),
    //       selector: (_, model) => model.state == AppState.loading,
    //     ),
    //   ],
    // );
    return const WidgetWithLoader<SignUpViewModel>(child: SignUpView());
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
                  style: StyleConstants.textStyle1,
                ),
                const SizedBox(height: 14),
                Opacity(
                  opacity: 0.60,
                  child: Text(
                    'We will send you a confirmation code',
                    style: StyleConstants.textStyle1.copyWith(fontSize: 14),
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
                SizedBox(
                  width: 309,
                  child: Text(
                    'Personal number please',
                    style: StyleConstants.textStyle1.copyWith(fontSize: 12),
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
                  Text(
                    'Request OTP on your registered email',
                    textAlign: TextAlign.center,
                    style: StyleConstants.textStyle1.copyWith(
                      color: const Color(0xFFE72D38),
                      fontSize: 14,
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
