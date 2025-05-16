import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/all_tickets_list_view.dart';
import 'package:manager_app/generated/l10n.dart';
import '../../../../../core/widget/custom_search.dart';
import '../../view_model/cubit/ticket_cubit.dart';
import 'sort_dialog.dart';

class AllTicketsViewBody extends StatefulWidget {
  const AllTicketsViewBody({super.key});

  @override
  State<AllTicketsViewBody> createState() => _AllTicketsViewBodyState();
}

class _AllTicketsViewBodyState extends State<AllTicketsViewBody> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TicketCubit>();
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<TicketCubit, TicketState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomSearch(
                        controller: searchController,
                        hintText: S.of(context).search,
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChange: (value) {
                          if (value.trim().isEmpty) {
                            cubit.fetchTickets();
                          } else {
                            cubit.searchTicket(value);
                          }
                        },
                        onSubmitted: (value) {
                          if (value.trim().isEmpty) {
                            cubit.fetchTickets();
                          } else {
                            cubit.searchTicket(value);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const SortDialog(),
                          );
                        },
                        icon: const Icon(
                          Icons.sort,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: (state is FetchTicketSuccess && state.tickets.isEmpty)
                      ? Center(
                          child: Text(
                            S.of(context).no_tickets,
                            style: AppStyles.textStyle16Black,
                          ),
                        )
                      : const AllTicketsListView(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
