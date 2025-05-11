import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/features/all_tickets/presentation/view/all_tickets.dart';
import 'package:manager_app/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:manager_app/features/settings/presentation/view/settings_view.dart';
import 'package:manager_app/features/home/presentation/view/widget/manager_drawer.dart';
import 'package:manager_app/features/notification/presentation/view_model/cubit/notification_cubit.dart';
import 'package:manager_app/generated/l10n.dart';
import '../../../add_ticketian/presentation/view/add_ticketian_view.dart';
import '../../../chat/presentation/view/chat_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ManagerHomeView extends StatefulWidget {
  int selectedIndex;
  ManagerHomeView({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<ManagerHomeView> createState() => _ManagerHomeViewState();
}

class _ManagerHomeViewState extends State<ManagerHomeView> {
  final List<Widget> pages = const [
    DashboardView(),
    AllTicketsView(),
    ChatView(),
    AddTicketianView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: [
          S.of(context).dashboard,
          S.of(context).allTickets,
          S.of(context).chat,
          S.of(context).addTicketian,
          S.of(context).setting
        ][widget.selectedIndex],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state is FetchNotificationSuccess) {
                  return IconButton(
                    onPressed: () {
                      context.push('/notification_view');
                    },
                    icon: Badge.count(
                      count: state.notifications.where((n) => !n.seen!).length,
                      child: const Icon(
                        Icons.notifications,
                        size: 27,
                      ),
                    ),
                  );
                } else if (state is FetchNotificationEmpty) {
                  return IconButton(
                    onPressed: () {
                      context.push('/notification_view');
                    },
                    icon: Badge.count(
                      count: 0,
                      child: const Icon(
                        Icons.notifications,
                        size: 27,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          )
        ],
      ),
      drawer: ManagerDrawer(
        activeIndex: widget.selectedIndex,
        onItemSelected: (index) {
          setState(() {
            widget.selectedIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: widget.selectedIndex,
        children: pages,
      ),
    );
  }
}
