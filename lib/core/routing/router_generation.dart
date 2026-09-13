import 'package:auto_swift/core/routing/app_routes.dart';
import 'package:auto_swift/features/admin/admin_page.dart';
import 'package:auto_swift/features/auth/auth_page.dart';
import 'package:auto_swift/features/home/car_details.dart';
import 'package:auto_swift/features/home/home_page.dart';
import 'package:go_router/go_router.dart';

class RouterGeneration {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.authPage,
    routes: [
      GoRoute(
        path: AppRoutes.adminPage,
        name: AppRoutes.adminPage,
        builder: (context, state) => AdminPage(),
      ),

      GoRoute(
        path: AppRoutes.homePage,
        name: AppRoutes.homePage,
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: AppRoutes.carDetailsPage,
        name: AppRoutes.carDetailsPage,
        builder: (context, state) {
          final carData = state.extra as Map<String, dynamic>;

          return CarDetails(
            carData: carData,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.authPage,
        name: AppRoutes.authPage,
        builder: (context, state) => const AuthPage(),
      ),
    ],
  );
}