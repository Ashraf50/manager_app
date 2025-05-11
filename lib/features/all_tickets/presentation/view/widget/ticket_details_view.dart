import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/constant/func/data_format.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/all_tickets/data/model/ticket_model/ticket_model/ticket_model.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/status_button.dart';
import 'package:manager_app/generated/l10n.dart';

class TicketsDetailsView extends StatelessWidget {
  final TicketModel ticket;
  const TicketsDetailsView({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: S.of(context).ticket_details,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomWidget(
              title: "${S.of(context).user_name}: ",
              subTitle: ticket.user?.name ?? "N/A",
            ),
            CustomWidget(
              title: "${S.of(context).service_name}: ",
              subTitle: ticket.service?.name ?? "N/A",
            ),
            CustomWidget(
              title: "${S.of(context).manager_name}: ",
              subTitle: ticket.manager?.user?.name ?? "N/A",
            ),
            CustomWidget(
              title: "${S.of(context).ticketian_name}: ",
              subTitle: ticket.technician?.user?.name ?? "N/A",
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${S.of(context).title}: ",
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
              "${S.of(context).details}: ",
              style: AppStyles.textStyle18bold,
            ),
            SelectableText(
              ticket.description ?? S.of(context).no_details,
              style: AppStyles.textStyle18black,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  S.of(context).status,
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
              S.of(context).created_at,
              style: AppStyles.textStyle18bold,
            ),
            SelectableText(
              dateTimeFormat(ticket.createdAt.toString(), 'd / M / y'),
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
