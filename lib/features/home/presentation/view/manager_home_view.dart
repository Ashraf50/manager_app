import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/features/all_tickets/presentation/view/all_tickets.dart';
import 'package:manager_app/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:manager_app/features/home/presentation/view/widget/manager_drawer.dart';
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: [
          'Dashboard',
          'All Tickets',
          'Chat',
          'Add Ticketian'
        ][widget.selectedIndex],
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
