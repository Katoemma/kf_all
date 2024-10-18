import 'package:get/get.dart';
import 'package:kijani_branch/app/middleware/role_guard.dart';
import 'package:kijani_branch/app/modules/auth/bindings/auth_bindings.dart';
import 'package:kijani_branch/app/modules/auth/views/login_view.dart';
import 'package:kijani_branch/app/modules/bc/views/bc_dashboard.dart';
import 'package:kijani_branch/app/routes/routes.dart';

class AppPages {
  static const INITIAL = Routes.login;

  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => LoginView(),
      binding: AuthBinding(), // Injects the AuthController
    ),
    // Role-based access to dashboards
    GetPage(
      name: Routes.bcDashboard,
      page: () => const Dashboard(),
      binding: AuthBinding(),
      middlewares: [RoleGuard('bc')], // Only allow BC access
    ),
    // GetPage(
    //   name: Routes.BC_DASHBOARD,
    //   page: () => const BcDashboard(),
    //   binding: BcBinding(),
    //   middlewares: [RoleGuard('BC')], // Only allow BC access
    // ),
    // GetPage(
    //   name: Routes.AC_DASHBOARD,
    //   page: () => const AcDashboard(),
    //   binding: AcBinding(),
    //   middlewares: [RoleGuard('AC')], // Only allow AC access
    // ),
    // GetPage(
    //   name: Routes.PMC_DASHBOARD,
    //   page: () => const PMCDashboard(),
    //   binding: PmcBinding(),
    //   middlewares: [RoleGuard('PMC')], // Only allow PMC access
    // ),
    // GetPage(
    //   name: Routes.MEL_DASHBOARD,
    //   page: () => const MELDashboard(),
    //   binding: MelBinding(),
    //   middlewares: [RoleGuard('MEL')], // Only allow MEL access
    // ),
  ];
}
