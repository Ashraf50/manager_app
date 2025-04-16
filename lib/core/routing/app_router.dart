import 'package:manager_app/features/Auth/presentation/view/reset_password_view.dart';
import 'package:manager_app/features/home/presentation/view/widget/edit_profile_view.dart';
import '../../features/Auth/presentation/view/forget_password_view.dart';
import '../../features/Auth/presentation/view/sign_in_view.dart';
import '../../features/all_tickets/presentation/view/widget/create_new_ticket_view.dart';
import '../../features/home/presentation/view/manager_home_view.dart';
import 'package:go_router/go_router.dart';
import '../../features/all_tickets/presentation/view/widget/ticket_details_view.dart';

class AppRouter {
  final bool isLoggedIn;
  AppRouter({required this.isLoggedIn});
  late final GoRouter router = GoRouter(
    initialLocation: isLoggedIn ? '/manager_home' : '/sign_in',
    routes: [
      GoRoute(
        path: '/sign_in',
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: '/forget_pass',
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: '/reset_pass',
        builder: (context, state) => const ResetPasswordView(),
      ),
      GoRoute(
          path: '/manager_home',
          builder: (context, state) {
            int pageIndex = state.extra is int ? state.extra as int : 0;
            return ManagerHomeView(selectedIndex: pageIndex);
          }),
      GoRoute(
        path: '/ticket_details',
        builder: (context, state) => const TicketsDetailsView(),
      ),
      GoRoute(
        path: '/edit_profile',
        builder: (context, state) => const EditProfileView(),
      ),
      GoRoute(
        path: '/create_ticket',
        builder: (context, state) => const CreateNewTicketView(),
      ),
    ],
  );
}
