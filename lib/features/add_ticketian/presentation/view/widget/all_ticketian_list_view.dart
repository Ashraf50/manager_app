import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/features/add_ticketian/presentation/view_model/cubit/add_ticketian_cubit.dart';
import 'ticketian_card.dart';

class AllTicketianListView extends StatelessWidget {
  const AllTicketianListView({super.key});

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
          borderRadius: BorderRadius.circular(13),
        ),
        child: BlocBuilder<AddTicketianCubit, AddTicketianState>(
          builder: (context, state) {
            if (state is FetchAllTicketianSuccess) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.ticketian.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.push(
                        '/ticketian_details',
                        extra: state.ticketian[index],
                      );
                    },
                    child: TicketianCard(
                      ticketian: state.ticketian[index],
                    ),
                  );
                },
              );
            } else if (state is FetchAllTicketianLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FetchAllTicketianFailure) {
              return Center(
                child: Text(state.errMessage),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
