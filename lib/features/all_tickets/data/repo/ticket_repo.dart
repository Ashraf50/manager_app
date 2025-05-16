import 'package:dartz/dartz.dart';
import 'package:manager_app/core/error/failure.dart';
import 'package:manager_app/features/all_tickets/data/model/ticket_model/ticket_model/ticket_model.dart';

abstract class TicketRepo {
  Future<List<TicketModel>> fetchAllTickets({int page = 1});
  Future<Either<Failure, List<TicketModel>>> sortTicket({
    required String from,
    required String to,
    required int ticketianId,
  });
  Future<Either<Failure, Unit>> assignTicket({
    required int ticketId,
    required int ticketianId,
  });
  Future<Either<Failure, Unit>> finishTicket({
    required int ticketId,
  });
  Future<Either<Failure, TicketModel>> getTicketById(int ticketId);
  Future<Either<Failure, List<TicketModel>>> searchTicket({required String name});
}
