import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/features/all_tickets/data/model/ticket_model/ticket_model/ticket_model.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/status_button.dart';
import 'package:manager_app/features/all_tickets/presentation/view_model/cubit/ticket_cubit.dart';

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
              PopupMenuButton(
                color: Colors.white,
                icon: const Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'assign',
                    child: Text('Assign'),
                  ),
                  const PopupMenuItem(
                    value: 'finish',
                    child: Text('Finish'),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'assign') {
                    context.push(
                      '/assign_ticket',
                      extra: ticket.id!,
                    );
                  } else if (value == 'finish') {
                    _showFinishDialog(context);
                  }
                },
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _showFinishDialog(BuildContext context) {
    SmartDialog.show(
      builder: (_) => AlertDialog(
        title: const Text('Confirm finish'),
        content: const Text('Are you sure you want to finish this Ticket?'),
        actions: [
          TextButton(
            onPressed: () => SmartDialog.dismiss(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TicketCubit>().finishTicket(ticketId: ticket.id!);
              SmartDialog.dismiss();
            },
            child: const Text('Finish', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
