import 'package:get/get.dart';
import 'package:wilford/auth/screens/forgot_password/forgot_screen.dart';
import 'package:wilford/auth/screens/forgot_password/reset_password.dart';
import 'package:wilford/auth/screens/login/login_screen.dart';
import 'package:wilford/auth/screens/onboarding/onboarding.dart';
import 'package:wilford/auth/screens/signUp/signup_screen.dart';
import 'package:wilford/auth/screens/signUp/verify_email.dart';
import 'package:wilford/commom/widgets/success_screen/payment_success_screen.dart';
import 'package:wilford/commom/widgets/success_screen/success_screen.dart';
import 'package:wilford/navigation_menu.dart';
import 'package:wilford/screens/gift_caed/screen/process.dart';
import 'package:wilford/screens/profile/profile.dart';
import 'package:wilford/screens/settings/screens/security/pin/manage_pin.dart';
import 'package:wilford/screens/settings/screens/security/pin/screens/set_pin.dart';
// Import other screens here

class AppRoutes {
  // Named routes as constants
  static const String signup = '/signup';
  static const String verifyEmail = '/verify-email';
  static const String login = '/login';
  static const String forgotton = '/forgotton';
  static const String successScreen = '/success_screen';
  static const String onboarding = '/onboarding';
  static const String resetPassword = '/reset_password';
  static const String home = '/home';
  static const String setpin = '/setpin';
  static const String giftcardProcess = '/giftcardProcess';
  static const String paymentSuccess = '/payment_success';
  static const String pinScreen = '/pin_screen';
  static const String profileScreen = '/profileScreen';

  // List of GetPage routes
  static final List<GetPage> routes = [
    GetPage(
      name: onboarding,
      page: () => const OnBoardingScreen(),
    ),

    GetPage(
      name: signup,
      page: () => const SignUpScreen(),
    ),

    GetPage(
      name: verifyEmail,
      page: () => const VerifyEmailScreen(),
    ),

    // Add more routes here
    GetPage(
      name: login,
      page: () => const LoginScreen(),
    ),

    // Successful login route
    GetPage(
      name: successScreen,
      page: () => const SuccessScreen(),
    ),

    // Payment success route
    GetPage(
      name: paymentSuccess,
      page: () => const PaymentSuccessScreen(),
    ),

    // Forgotton Screen
    GetPage(
      name: forgotton,
      page: () => const ForgotPassword(),
    ),

    // Reset Password Screen
    GetPage(
      name: resetPassword,
      page: () => const ResetPassword(),
    ),

    /// Home
    GetPage(
      name: home,
      page: () => const NavigationMenu(),
    ),

    // Gift card process
    GetPage(
      name: giftcardProcess,
      page: () => const GiftProcessScreen(),
    ),

    // Set Pin
    GetPage(
      name: setpin,
      page: () => const TSetNewPin(),
    ),

    // Manage Pin
    GetPage(
      name: pinScreen,
      page: () => const ManagePinScreen(),
    ),

    // Profile Screen
    GetPage(
      name: profileScreen,
      page: () => const ProfileScreen(),
    ),
  ];
}
