import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/ticket_card.dart';

class AllTicketsListView extends StatelessWidget {
  const AllTicketsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(13)),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.push("/ticket_details");
              },
              child: const TicketCard(),
            );
          },
        ),
      ),
    );
  }
}
