import '../../../../../core/ui/widgets/app_bar/api_loader_screen.dart';
import '../../../../../core/ui/widgets/app_bar/app_bar_widget.dart';
import '../../../../../core/ui/widgets/custom_red_button.dart';
import '../../constants/assets_constants.dart';
import '../../view_models/basic_details_view_model.dart';
import '../../../sign_up/constants/style_constants.dart';
import '../../../sign_up/view_models/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicDetailsScreen extends StatelessWidget {
  const BasicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BasicDetailView(),
        Selector<BasicDetailViewModel, bool>(
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
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              'Lets get started with your basic details ✌️',
              style: StyleConstants.textStyle1.copyWith(
                color: const Color(0xFF302F2F),
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              onChanged: (value) =>
                  context.read<BasicDetailViewModel>().onFirstNameChange(value),
              decoration: StyleConstants.inputDecoration1.copyWith(
                prefixIcon: Image.asset(AssetsConstants.personAsset),
                hintText: 'First Name',
              ),
            ),
            const SizedBox(height: 34),
            TextField(
              onChanged: (value) =>
                  context.read<BasicDetailViewModel>().onLastNameChange(value),
              decoration: StyleConstants.inputDecoration1.copyWith(
                prefixIcon: Image.asset(AssetsConstants.personAsset),
                hintText: 'Last Name',
              ),
            ),
            const SizedBox(height: 34),
            TextField(
              onChanged: (value) =>
                  context.read<BasicDetailViewModel>().onUserEmailChange(value),
              decoration: StyleConstants.inputDecoration1.copyWith(
                prefixIcon: Image.asset(AssetsConstants.personAsset),
                hintText: 'Your Email id',
              ),
            ),
            const SizedBox(height: 34),
            TextField(
              onChanged: (value) =>
                  context.read<BasicDetailViewModel>().onUserNameChange(value),
              decoration: StyleConstants.inputDecoration1.copyWith(
                prefixIcon: Image.asset(AssetsConstants.personAsset),
                hintText: 'Choose user name',
              ),
            ),
            const SizedBox(height: 34),
            const Spacer(),
            Text(
              'Fetch data from',
              textAlign: TextAlign.center,
              style: StyleConstants.textStyle1.copyWith(
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
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: CustomRedButton(
                labelText: 'Continue',
                onTap: () {
                  context.read<BasicDetailViewModel>().submitUserData();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
