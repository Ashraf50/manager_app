import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/all_tickets_list_view.dart';
import '../../view_model/cubit/ticket_cubit.dart';
import 'add_button.dart';
import 'sort_dialog.dart';

class AllTicketsViewBody extends StatelessWidget {
  const AllTicketsViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<TicketCubit, TicketState>(
        builder: (context, state) {
          int ticketCount = 0;
          if (state is FetchTicketSuccess) {
            ticketCount = state.tickets.length;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Text(
                        "$ticketCount",
                        style: AppStyles.textStyle18bold,
                      ),
                    ),
                    AddButton(
                      title: "Filter Tickets",
                      icon: const Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => const SortDialog(),
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Expanded(
                  child: AllTicketsListView(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
