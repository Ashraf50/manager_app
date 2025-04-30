part of 'create_ticketian_cubit.dart';

sealed class CreateTicketianState {}

class CreateTicketianInitial extends CreateTicketianState {}

final class CreateTicketianLoading extends CreateTicketianState {}

final class CreateTicketianSuccess extends CreateTicketianState {}

final class CreateTicketianFailure extends CreateTicketianState {
  final String errMessage;
  CreateTicketianFailure({required this.errMessage});
}
