part of 'ticket_cubit.dart';

sealed class TicketState {}

final class TicketInitial extends TicketState {}

final class FetchTicketLoading extends TicketState {}

final class FetchTicketSuccess extends TicketState {
  final List<TicketModel> tickets;
  FetchTicketSuccess({required this.tickets});
}

final class FetchTicketFailure extends TicketState {
  final String errMessage;
  FetchTicketFailure({required this.errMessage});
}
