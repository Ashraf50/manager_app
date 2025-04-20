import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/features/all_tickets/data/model/ticket_model/ticket_model/ticket_model.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/status_button.dart';

class TicketCard extends StatelessWidget {
  final TicketModel ticket;
  const TicketCard({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      ticket.service!.name!,
                      style: AppStyles.textStyle18black,
                      softWrap: true,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      Text(
                        ticket.user!.name!,
                        style: AppStyles.textStyle16,
                      ),
                    ],
                  ),
                ],
              ),
              StatusButton(
                status: ticket.status!,
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
