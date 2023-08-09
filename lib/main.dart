import 'features/onboarding/basic_details/ui/screens/basic_details_screen.dart';
import 'features/onboarding/basic_details/view_models/basic_details_view_model.dart';
import 'features/onboarding/sign_up/ui/screens/otp_screen.dart';
import 'features/onboarding/sign_up/ui/screens/sign_up.screen.dart';
import 'features/onboarding/sign_up/view_models/sign_up_view_model.dart';
import 'routes/routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => BasicDetailViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        // initialRoute: RouteConstansts.basicDetails,
        routes: {
          RouteConstansts.initialRoute: (context) =>
              const SignUpWithPhoneScreen(),
          RouteConstansts.otpScreen: (context) => const OTPScreen(),
          RouteConstansts.basicDetails: (context) => const BasicDetailsScreen(),
        },
      ),
    );
  }
}
