import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/core/widget/custom_toast.dart';
import 'package:manager_app/features/all_tickets/data/model/ticket_model/ticket_model/ticket_model.dart';
import 'package:manager_app/features/all_tickets/data/repo/ticket_repo.dart';
part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketRepo ticketRepo;
  List<TicketModel> allTickets = [];
  int currentPage = 1;
  bool hasMore = true;
  bool isFetching = false;
  TicketCubit(this.ticketRepo) : super(TicketInitial());

  Future<void> fetchTickets({bool loadMore = false, bool reset = false}) async {
    if (isFetching || (!hasMore && !reset)) return;
    isFetching = true;
    if (reset) {
      allTickets = [];
      currentPage = 1;
      hasMore = true;
    }
    if (!loadMore || reset) {
      emit(FetchTicketLoading());
    }
    try {
      final fetchedTickets =
          await ticketRepo.fetchAllTickets(page: currentPage);
      if (fetchedTickets.isEmpty) {
        hasMore = false;
      } else {
        allTickets = [...allTickets, ...fetchedTickets];
        currentPage++;
      }
      emit(FetchTicketSuccess(tickets: List.from(allTickets)));
    } catch (e) {
      emit(FetchTicketFailure(errMessage: "Failed to load tickets"));
    }
    isFetching = false;
  }

  void loadMoreTickets() {
    fetchTickets(loadMore: true);
  }

  Future<void> fetchSortedTickets({
    required String from,
    required String to,
    required int ticketianId,
  }) async {
    emit(FetchTicketLoading());
    final result = await ticketRepo.sortTicket(
        from: from, to: to, ticketianId: ticketianId);
    result.fold(
      (failure) {
        CustomToast.show(
            message: failure.errMessage, backgroundColor: Colors.red);
        emit(FetchTicketSuccess(tickets: List.from(allTickets)));
      },
      (tickets) => emit(FetchTicketSuccess(tickets: tickets)),
    );
  }

  Future<bool> assignTicketian({
    required int ticketId,
    required int ticketianId,
  }) async {
    emit(FetchTicketLoading());
    final result = await ticketRepo.assignTicket(
      ticketId: ticketId,
      ticketianId: ticketianId,
    );
    return result.fold(
      (failure) {
        CustomToast.show(
            message: failure.errMessage, backgroundColor: Colors.red);
        emit(FetchTicketSuccess(tickets: List.from(allTickets)));
        return false;
      },
      (_) async {
        await fetchTickets(reset: true);
        return true;
      },
    );
  }

  Future<bool> finishTicket({
    required int ticketId,
  }) async {
    emit(FetchTicketLoading());
    final result = await ticketRepo.finishTicket(
      ticketId: ticketId,
    );
    return result.fold(
      (failure) {
        CustomToast.show(
            message: failure.errMessage, backgroundColor: Colors.red);
        emit(FetchTicketSuccess(tickets: List.from(allTickets)));
        return false;
      },
      (_) async {
        await fetchTickets(reset: true);
        return true;
      },
    );
  }
}
