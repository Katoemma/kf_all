import 'package:get/get.dart';
import 'package:kijani_branch/app/middleware/role_guard.dart';
import 'package:kijani_branch/app/modules/auth/bindings/auth_bindings.dart';
import 'package:kijani_branch/app/modules/auth/views/login_view.dart';
import 'package:kijani_branch/app/modules/bc/bindings/bc_bindngs.dart';
import 'package:kijani_branch/app/modules/mel/bindings/bc_bindngs.dart';
import 'package:kijani_branch/app/modules/mel/views/dashboard.dart';
import 'package:kijani_branch/app/modules/pmc/bindings/bc_bindngs.dart';
import 'package:kijani_branch/app/modules/pmc/views/dashboard.dart';
import 'package:kijani_branch/app/routes/routes.dart';
import 'package:kijani_branch/app/modules/bc/views/dashboard.dart';

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
      page: () => const BcDashboard(),
      binding: BcBinding(),
      middlewares: [RoleGuard('bc')], // Only allow BC access
    ),
    GetPage(
      name: Routes.pmcDashboard,
      page: () => const PmcDashboard(),
      binding: PmcBinding(),
      middlewares: [RoleGuard('pmc')], // Only allow PMC access
    ),
    GetPage(
      name: Routes.melDashboard,
      page: () => const MelDashboard(),
      binding: MelBinding(),
      middlewares: [RoleGuard('mel')], // Only allow MEL access
    ),
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
