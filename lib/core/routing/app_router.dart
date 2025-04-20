import 'package:manager_app/features/Auth/presentation/view/reset_password_view.dart';
import 'package:manager_app/features/add_ticketian/data/model/ticketian_model/ticketian_model.dart';
import 'package:manager_app/features/add_ticketian/presentation/view/widget/add_new_ticketian.dart';
import 'package:manager_app/features/add_ticketian/presentation/view/widget/ticketian_details_view.dart';
import 'package:manager_app/features/all_tickets/data/model/ticket_model/ticket_model/ticket_model.dart';
import 'package:manager_app/features/home/presentation/view/widget/edit_profile_view.dart';
import '../../features/Auth/presentation/view/forget_password_view.dart';
import '../../features/Auth/presentation/view/sign_in_view.dart';
import '../widget/photo_view.dart';
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
          builder: (context, state) {
            var ticket = state.extra as TicketModel;
            return TicketsDetailsView(ticket: ticket);
          }),
      GoRoute(
          path: '/ticketian_details',
          builder: (context, state) {
            var ticketian = state.extra as TicketianModel;
            return TicketianDetailsView(ticketian: ticketian);
          }),
      GoRoute(
          path: '/photo_view',
          builder: (context, state) {
            var image = state.extra as String;
            return PhotoViewer(image: image);
          }),
      GoRoute(
        path: '/edit_profile',
        builder: (context, state) => const EditProfileView(),
      ),
      GoRoute(
        path: '/add_new_ticketian',
        builder: (context, state) => const AddNewTicketian(),
      ),
    ],
  );
}
