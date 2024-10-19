import 'package:get/get.dart';
import 'package:kijani_branch/app/global/dashboard/views/index.dart';
import 'package:kijani_branch/app/global/parish/bindings/parish_bindings.dart';
import 'package:kijani_branch/app/global/parish/views/index.dart';
import 'package:kijani_branch/app/middleware/role_guard.dart';
import 'package:kijani_branch/app/modules/auth/bindings/auth_bindings.dart';
import 'package:kijani_branch/app/modules/auth/views/login_view.dart';
import 'package:kijani_branch/app/modules/bc/bindings/bc_bindngs.dart';
import 'package:kijani_branch/app/modules/mel/bindings/bc_bindngs.dart';
import 'package:kijani_branch/app/modules/pmc/bindings/bc_bindngs.dart';
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
      binding: BcBinding(),
      middlewares: [RoleGuard('bc')], // Only allow BC access
    ),
    GetPage(
      name: Routes.pmcDashboard,
      page: () => const Dashboard(),
      binding: PmcBinding(),
      middlewares: [RoleGuard('pmc')], // Only allow PMC access
    ),
    GetPage(
      name: Routes.melDashboard,
      page: () => const Dashboard(),
      binding: MelBinding(),
      middlewares: [RoleGuard('mel')], // Only allow MEL access
    ),
    GetPage(
      name: Routes.parish,
      page: () => const ParishDetailScreen(),
      binding: ParishBinding(),
    ),
  ];
}
