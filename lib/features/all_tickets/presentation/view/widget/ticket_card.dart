import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/status_button.dart';
import 'package:manager_app/features/all_tickets/presentation/view_model/cubit/ticket_cubit.dart';
import 'package:manager_app/generated/l10n.dart';

class TicketCard extends StatelessWidget {
  final String ticketName;
  final int id;
  final String userName;
  final int status;
  const TicketCard({
    super.key,
    required this.id,
    required this.ticketName,
    required this.userName,
    required this.status,
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
                      ticketName,
                      style: AppStyles.textStyle18black,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      Text(
                        userName,
                        style: AppStyles.textStyle16,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  StatusButton(
                    status: status,
                  ),
                  if (status == 0 || status == 1)
                    PopupMenuButton(
                      color: Colors.white,
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) {
                        final List<PopupMenuItem> items = [];
                        if (status == 0) {
                          items.add(
                            PopupMenuItem(
                              value: 'assign',
                              child: Text(S.of(context).assign),
                            ),
                          );
                        }
                        if (status == 1) {
                          items.add(
                            PopupMenuItem(
                              value: 'finish',
                              child: Text(S.of(context).finish),
                            ),
                          );
                        }
                        return items;
                      },
                      onSelected: (value) {
                        if (value == 'assign') {
                          context.push(
                            '/assign_ticket',
                            extra: id,
                          );
                        } else if (value == 'finish') {
                          _showFinishDialog(context);
                        }
                      },
                    )
                  else
                    const SizedBox(width: 40), // Placeholder for alignment
                ],
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
        title: Text(S.of(context).confirm_finish),
        content: Text(S.of(context).sure_finish_Ticket),
        actions: [
          TextButton(
            onPressed: () => SmartDialog.dismiss(),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<TicketCubit>().finishTicket(ticketId: id);
              SmartDialog.dismiss();
            },
            child: Text(S.of(context).finish,
                style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
