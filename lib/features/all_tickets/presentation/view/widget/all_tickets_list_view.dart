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
  late ScrollController _scrollController;
  late TicketCubit ticketCubit;

  @override
  void initState() {
    super.initState();
    ticketCubit = context.read<TicketCubit>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      ticketCubit.loadMoreTickets();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.95);
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
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.tickets.length,
                itemBuilder: (context, index) {
                  final tickets = state.tickets[index];
                  return InkWell(
                    onTap: () {
                      context.push(
                        "/ticket_details",
                        extra: tickets,
                      );
                    },
                    child: TicketCard(
                      ticket: tickets,
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
