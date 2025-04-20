import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/cubit/ticket_cubit.dart';
import 'ticket_card.dart';

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
        child: BlocBuilder<TicketCubit, TicketState>(
          builder: (context, state) {
            if (state is FetchTicketSuccess) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.tickets.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.push(
                        "/ticket_details",
                        extra: state.tickets[index],
                      );
                    },
                    child: TicketCard(
                      ticket: state.tickets[index],
                    ),
                  );
                },
              );
            } else if (state is FetchTicketLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FetchTicketFailure) {
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
