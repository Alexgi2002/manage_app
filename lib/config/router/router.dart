import 'package:manage_app/data/storage.dart';
import 'package:manage_app/domain/entities/order.dart';
import 'package:manage_app/presentation/pages/change_password_page.dart';
import 'package:manage_app/presentation/pages/pages.dart';
import 'package:go_router/go_router.dart';

import 'router_path.dart';
import 'router_transition.dart';

final appRouter = GoRouter(
  initialLocation: Storage.instance.getId() == -1 ? RouterPath.LOGIN_PAGE : RouterPath.HOME_PAGE,
  routes: [
    GoRoute(
      path: RouterPath.LOGIN_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: const LoginPage()),
    ),
    GoRoute(
      path: RouterPath.HOME_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: const HomePage()),
    ),
    GoRoute(
      path: RouterPath.SCAN_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: const ScanPage()),
    ),
    GoRoute(
      path: RouterPath.ADD_ORDER_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: AddOrderPage(order: state.extra as Order?)), 
    ),
    GoRoute(
      path: RouterPath.SETTINGS_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: const SettingsPage()),
    ),
    GoRoute(
      path: RouterPath.CHANGE_PASSWORD_PAGE,
      pageBuilder: (context, state) =>
        RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: ChangePasswordPage()),
    ),

  ],
);
