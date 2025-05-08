import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/status_button.dart';
import 'package:manager_app/features/dashboard/data/model/statistics/recent_ticket.dart';
import '../../../../../core/constant/func/data_format.dart';

class DashboardTicketDetails extends StatelessWidget {
  final RecentTicket ticket;
  const DashboardTicketDetails({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: "Ticket Details",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomWidget(
              title: "User name: ",
              subTitle: ticket.user?.name ?? "N/A",
            ),
            CustomWidget(
              title: "Service name: ",
              subTitle: ticket.service?.name ?? "N/A",
            ),
            CustomWidget(
              title: "Manager name: ",
              subTitle: ticket.manager?.user?.name ?? "N/A",
            ),
            CustomWidget(
              title: "Ticketian name: ",
              subTitle: ticket.technician?.user?.name ?? "N/A",
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Title:",
              style: AppStyles.textStyle18bold,
            ),
            SelectableText(
              ticket.title ?? "No Title",
              style: AppStyles.textStyle18black,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Details:",
              style: AppStyles.textStyle18bold,
            ),
            SelectableText(
              ticket.description ?? "No Details Available",
              style: AppStyles.textStyle18black,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  "Status",
                  style: AppStyles.textStyle18bold,
                ),
                const SizedBox(
                  width: 30,
                ),
                StatusButton(
                  status: ticket.status!,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Created at:",
              style: AppStyles.textStyle18bold,
            ),
            SelectableText(
              dateTimeFormat(
                  ticket.createdAt.toString(), 'd / M / y - h : mm '),
              style: AppStyles.textStyle18black,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const CustomWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            title,
            style: AppStyles.textStyle18bold,
          ),
          Expanded(
            child: SelectableText(
              subTitle,
              style: AppStyles.textStyle18black,
            ),
          ),
        ],
      ),
    );
  }
}
