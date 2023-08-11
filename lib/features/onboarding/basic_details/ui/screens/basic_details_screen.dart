import 'package:auth_module/core/ui/widgets/widget_with_loader.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/ui/widgets/app_bar/api_loader_screen.dart';
import '../../../../../core/ui/widgets/app_bar/app_bar_widget.dart';
import '../../../../../core/ui/widgets/custom_red_button.dart';
import '../../constants/assets_constants.dart';
import '../../view_models/basic_details_view_model.dart';
import '../../../sign_up/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicDetailsScreen extends StatelessWidget {
  const BasicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   children: [
    //     const BasicDetailView(),
    //     Selector<BasicDetailViewModel, bool>(
    //       builder: (_, isLoading, child) => Visibility(
    //         visible: isLoading,
    //         child: const ApiLoaderScreen(),
    //       ),
    //       selector: (_, model) => model.isLoading,
    //     ),
    //   ],
    // );
    return const WidgetWithLoader<BasicDetailViewModel>(
      child: BasicDetailView(),
    );
  }
}

class BasicDetailView extends StatelessWidget {
  const BasicDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        appBarTitle: "Myself",
        isLeadingButton: true,
        leadingWidth: 70,
        transformValue: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Lets get started with your basic details ✌️',
                    style: StyleConstants.textStyle2.copyWith(
                      color: const Color(0xFF302F2F),
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    onChanged: (value) => context
                        .read<BasicDetailViewModel>()
                        .onFirstNameChange(value),
                    decoration: StyleConstants.inputDecoration1.copyWith(
                      prefixIcon: SvgPicture.asset(
                        AssetsConstants.personAsset,
                        height: 5,
                        width: 5,
                        fit: BoxFit.scaleDown,
                      ),
                      hintText: 'First Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'First name is required',
                        style: StyleConstants.textStyle1.copyWith(
                            fontSize: 12, color: Colors.grey.shade700),
                      ),
                      Consumer<BasicDetailViewModel>(
                        builder: (context, value, child) => Text(
                          '${value.userInfoModel.firstname.length}/12',
                          style: StyleConstants.textStyle1.copyWith(
                              fontSize: 12, color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) => context
                        .read<BasicDetailViewModel>()
                        .onLastNameChange(value),
                    decoration: StyleConstants.inputDecoration1.copyWith(
                      prefixIcon: SvgPicture.asset(
                        AssetsConstants.personAsset,
                        height: 5,
                        width: 5,
                        fit: BoxFit.scaleDown,
                      ),
                      hintText: 'Last Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Last name is optional',
                        style: StyleConstants.textStyle1.copyWith(
                            fontSize: 12, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) => context
                        .read<BasicDetailViewModel>()
                        .onUserEmailChange(value),
                    decoration: StyleConstants.inputDecoration1.copyWith(
                      prefixIcon: SvgPicture.asset(
                        AssetsConstants.emailAsset,
                        height: 5,
                        width: 5,
                        fit: BoxFit.scaleDown,
                      ),
                      hintText: 'Your Email id',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Consumer<BasicDetailViewModel>(
                        builder: (context, viewModel, child) {
                          if (viewModel.emailError != null) {
                            return Column(
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  viewModel.emailError!,
                                  style: StyleConstants.textStyle1.copyWith(
                                    color: const Color(0xFFE72D38),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 34),
                  TextField(
                    onChanged: (value) => context
                        .read<BasicDetailViewModel>()
                        .onUserNameChange(value),
                    decoration: StyleConstants.inputDecoration1.copyWith(
                      prefixIcon: SvgPicture.asset(
                        AssetsConstants.usernameAsset,
                        height: 5,
                        width: 5,
                        fit: BoxFit.scaleDown,
                      ),
                      hintText: 'Choose user name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Consumer<BasicDetailViewModel>(
                        builder: (context, viewModel, child) {
                          if (viewModel.usernameError != null) {
                            return Column(
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  viewModel.usernameError!,
                                  style: StyleConstants.textStyle1.copyWith(
                                    color: const Color(0xFFE72D38),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox(height: 34);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Column(
                children: [
                  Text(
                    'Fetch data from',
                    textAlign: TextAlign.center,
                    style: StyleConstants.textStyle2.copyWith(
                      color: const Color(0xFF5F5F5F),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(AssetsConstants.facebookLogo),
                      Image.asset(AssetsConstants.instagramLogo),
                      Image.asset(AssetsConstants.twitterLogo),
                      Image.asset(AssetsConstants.googleLogo),
                      Image.asset(AssetsConstants.linkedInLogo),
                    ],
                  ),
                  const SizedBox(height: 38),
                  Consumer<BasicDetailViewModel>(
                    builder: (context, viewModel, child) => Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: CustomRedButton(
                        labelText: 'Continue',
                        onTap: (viewModel.isFirstNameValid &&
                                viewModel.isEmailValid &&
                                viewModel.isUsernameValid)
                            ? () {
                                context
                                    .read<BasicDetailViewModel>()
                                    .submitUserData();
                              }
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
