import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/add_ticketian/presentation/view/widget/all_ticketian_list_view.dart';
import 'package:manager_app/features/add_ticketian/presentation/view_model/cubit/add_ticketian_cubit.dart';
import '../../../../../../../core/constant/app_styles.dart';
import '../../../../../../../core/widget/custom_search.dart';
import '../../../../all_tickets/presentation/view/widget/add_button.dart';

class AddTicketianViewBody extends StatelessWidget {
  const AddTicketianViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final cubit = context.read<AddTicketianCubit>();
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<AddTicketianCubit, AddTicketianState>(
          builder: (context, state) {
            int ticketianCount = 0;
            if (state is FetchAllTicketianSuccess) {
              ticketianCount = state.ticketian.length;
            }
            return ListView(
              children: [
                CustomSearch(
                  controller: searchController,
                  hintText: "search",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  onChange: (value) {
                    if (value.isEmpty) {
                      cubit.fetchTicketian();
                    } else {
                      cubit.searchTicketian(value);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
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
                        "$ticketianCount",
                        style: AppStyles.textStyle18bold,
                      ),
                    ),
                    AddButton(
                      title: "Create New",
                      onTap: () {
                        context.push("/add_new_ticketian");
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const AllTicketianListView(),
                const SizedBox(
                  height: 40,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
