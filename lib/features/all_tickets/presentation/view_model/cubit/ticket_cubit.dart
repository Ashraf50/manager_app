import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/all_tickets/data/model/ticket_model/ticket_model/ticket_model.dart';
import 'package:manager_app/features/all_tickets/data/repo/ticket_repo.dart';
part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketRepo ticketRepo;
  TicketCubit(this.ticketRepo) : super(TicketInitial());
  Future<void> fetchTickets() async {
    emit(FetchTicketLoading());
    var result = await ticketRepo.fetchAllTickets();
    result.fold(
      (failure) {
        emit(
          FetchTicketFailure(errMessage: failure.errMessage),
        );
      },
      (tickets) {
        emit(
          FetchTicketSuccess(tickets: tickets),
        );
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
}
