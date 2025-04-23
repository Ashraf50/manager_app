import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/cubit/ticket_cubit.dart';
import 'ticket_card.dart';

class AllTicketsListView extends StatefulWidget {
  const AllTicketsListView({super.key});

  @override
  State<AllTicketsListView> createState() => _AllTicketsListViewState();
}

class _AllTicketsListViewState extends State<AllTicketsListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<TicketCubit>().fetchTickets();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    print(
        "Scrolling... Position: ${_scrollController.position.pixels}, Max: ${_scrollController.position.maxScrollExtent}");
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 10 &&
        !context.read<TicketCubit>().isFetching &&
        context.read<TicketCubit>().hasMore) {
      print("Fetching more tickets...");
      context.read<TicketCubit>().fetchTickets(loadMore: true);
    }
  }

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
        child: BlocBuilder<TicketCubit, TicketState>(
          builder: (context, state) {
            if (state is FetchTicketSuccess) {
              print(
                  "Tickets count: ${state.tickets.length}, hasMore: ${state.hasMore}");
              return ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.tickets.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= state.tickets.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
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
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchTicketFailure) {
              return Center(child: Text(state.errMessage));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
