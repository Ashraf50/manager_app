import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/status_button.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key});

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
                  Text(
                    "Title",
                    style: AppStyles.textStyle18black,
                  ),
                  Row(
                    children: [
                      Text(
                        "Subtitle",
                        style: AppStyles.textStyle16,
                      ),
                      const Icon(
                        Icons.person,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ],
              ),
              const StatusButton(),
              PopupMenuButton(
                color: Colors.white,
                icon: const Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'edit') {
                  } else if (value == 'delete') {}
                },
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
