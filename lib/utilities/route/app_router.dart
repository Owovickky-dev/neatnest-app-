import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/screens/booking/widgets/booking_form_screen.dart';
import 'package:neat_nest/screens/home/filter/filter_screen.dart';
import 'package:neat_nest/screens/home/widget/all_ads_screen.dart';
import 'package:neat_nest/screens/home/widget/notification_screen.dart';
import 'package:neat_nest/screens/onboarding/welcome_screen.dart';
import 'package:neat_nest/screens/user/auth/signin/sign_in_screen.dart';
import 'package:neat_nest/screens/user/auth/signin/utilities/forget_password_screen.dart';
import 'package:neat_nest/screens/user/auth/signup/sign_up_screen.dart';
import 'package:neat_nest/screens/user/user_profile_screen.dart';
import 'package:neat_nest/screens/user/user_screen.dart';
import 'package:neat_nest/screens/user/utilities/add_address_holder.dart';
import 'package:neat_nest/screens/user/widgets/edit_profile/edit_profile_screen.dart';
import 'package:neat_nest/screens/user/widgets/edit_profile/widget/personal_info_edit.dart';
import 'package:neat_nest/screens/user/widgets/edit_profile/widget/user_address_screen.dart';
import 'package:neat_nest/screens/user/widgets/in_reg_screen.dart';
import 'package:neat_nest/screens/user/widgets/payment/user_payment_method.dart';
import 'package:neat_nest/screens/user/widgets/payment/widgets/add_payment_method.dart';
import 'package:neat_nest/screens/user/widgets/payment/worker_payment_method.dart';
import 'package:neat_nest/screens/user/widgets/verification/worker_verification_screen.dart';
import 'package:neat_nest/utilities/bottom_nav/bottom_navigation_screen.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';

import '../../screens/onboarding/widgets/splash_screen.dart';
import '../../screens/user/model/user_payment_method_model.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/splash",
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.welcome.path,
        name: AppRoute.welcome.name,
        builder: (context, state) => WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoute.bottomNavigation.path,
        name: AppRoute.bottomNavigation.name,
        builder: (context, state) {
          return BottomNavigationScreen();
        },
      ),
      GoRoute(
        path: AppRoute.signUp.path,
        name: AppRoute.signUp.name,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: AppRoute.signIn.path,
        name: AppRoute.signIn.name,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: AppRoute.workerVerificationScreen.path,
        name: AppRoute.workerVerificationScreen.name,
        builder: (context, state) => WorkerVerificationScreen(),
      ),
      GoRoute(
        path: AppRoute.editProfile.path,
        name: AppRoute.editProfile.name,
        builder: (context, state) => EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoute.forgotPassword.path,
        name: AppRoute.forgotPassword.name,
        builder: (context, state) => ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoute.notification.path,
        name: AppRoute.notification.name,
        builder: (context, state) => NotificationScreen(),
      ),
      GoRoute(
        path: AppRoute.filterData.path,
        name: AppRoute.filterData.name,
        builder: (context, state) => FilterScreen(),
      ),
      GoRoute(
        path: AppRoute.bookingFormScreen.path,
        name: AppRoute.bookingFormScreen.name,
        builder: (context, state) => BookingFormScreen(),
      ),
      GoRoute(
        path: AppRoute.userProfile.path,
        name: AppRoute.userProfile.name,
        builder: (context, state) => UserProfileScreen(),
      ),
      GoRoute(
        path: AppRoute.allAdsScreen.path,
        name: AppRoute.allAdsScreen.name,
        builder: (context, state) => AllAdsScreen(),
      ),
      GoRoute(
        path: AppRoute.personalInfoEdit.path,
        name: AppRoute.personalInfoEdit.name,
        builder: (context, state) => PersonalInfoEdit(),
      ),
      GoRoute(
        path: AppRoute.inReg.path,
        name: AppRoute.inReg.name,
        builder: (context, state) => InRegScreen(),
      ),
      GoRoute(
        path: AppRoute.userScreenLog.path,
        name: AppRoute.userScreenLog.name,
        builder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>?;
          final isDataAvailable = extraData?['isDataAvailable'] ?? false;
          return UserScreen(isDataAvailable: isDataAvailable);
        },
      ),
      GoRoute(
        path: AppRoute.workerPaymentMethod.path,
        name: AppRoute.workerPaymentMethod.name,
        builder: (context, state) => WorkerPaymentMethod(),
      ),
      GoRoute(
        path: AppRoute.userPaymentMethod.path,
        name: AppRoute.userPaymentMethod.name,
        builder: (context, state) => UserPaymentMethod(),
      ),
      GoRoute(
        path: AppRoute.userAddresses.path,
        name: AppRoute.userAddresses.name,
        builder: (context, state) => UserAddressScreen(),
      ),
      GoRoute(
        path: AppRoute.addressHolder.path,
        name: AppRoute.addressHolder.name,
        builder: (context, state) => AddAddressHolder(),
      ),
      GoRoute(
        path: AppRoute.addPaymentMethod.path,
        name: AppRoute.addPaymentMethod.name,
        builder: (context, state) {
          final paymentMethod = state.extra as UserPaymentMethodModel?;
          return AddPaymentMethod(userExistingData: paymentMethod);
        },
      ),
    ],
  );
});
