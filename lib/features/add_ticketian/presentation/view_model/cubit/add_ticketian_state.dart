part of 'add_ticketian_cubit.dart';

sealed class AddTicketianState {}

final class AddTicketianInitial extends AddTicketianState {}

final class FetchAllTicketianLoading extends AddTicketianState {}

final class FetchAllTicketianSuccess extends AddTicketianState {
  final List<TicketianModel> ticketian;
  FetchAllTicketianSuccess({required this.ticketian});
}

final class FetchAllTicketianFailure extends AddTicketianState {
  final String errMessage;
  FetchAllTicketianFailure({required this.errMessage});
}

final class EditTicketianSuccess extends AddTicketianState {}

final class EditTicketianFailure extends AddTicketianState {
  final String errMessage;
  EditTicketianFailure({required this.errMessage});
}
