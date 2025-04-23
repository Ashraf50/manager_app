import 'package:flutter_bloc/flutter_bloc.dart';
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

  Future<void> fetchTickets({bool loadMore = false}) async {
    if (isFetching || (loadMore && !hasMore)) return;

    isFetching = true;

    if (loadMore) {
      emit(FetchTicketLoadingMore());
    } else {
      currentPage = 1;
      emit(FetchTicketLoading());
    }

    var result = await ticketRepo.fetchAllTickets(page: currentPage);

    result.fold(
      (failure) {
        isFetching = false;
        print("Fetch failed: ${failure.errMessage}");
        emit(FetchTicketFailure(errMessage: failure.errMessage));
      },
      (response) {
        isFetching = false;
        print("Fetched ${response.tickets.length} tickets");
        if (loadMore) {
          allTickets.addAll(response.tickets);
        } else {
          allTickets = response.tickets;
        }
        hasMore = response.currentPage < response.lastPage ||
            response.tickets.length < response.total;
        currentPage = response.currentPage + 1;
        print("hasMore: $hasMore, currentPage: $currentPage");
        emit(FetchTicketSuccess(
          tickets: allTickets,
          hasMore: hasMore,
        ));
      },
    );
  }

  Future<void> fetchSortedTickets(
      {required String from,
      required String to,
      required int serviceId}) async {
    emit(FetchTicketLoading());
    final result =
        await ticketRepo.sortTicket(from: from, to: to, serviceId: serviceId);
    result.fold(
      (failure) => emit(FetchTicketFailure(errMessage: failure.errMessage)),
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
        emit(FetchTicketFailure(errMessage: failure.errMessage));
        return false;
      },
      (_) async {
        await fetchTickets();
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
        emit(FetchTicketFailure(errMessage: failure.errMessage));
        return false;
      },
      (_) async {
        await fetchTickets();
        return true;
      },
    );
  }
}
