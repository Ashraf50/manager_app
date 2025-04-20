import 'package:dartz/dartz.dart';
import 'package:manager_app/core/error/failure.dart';
import 'package:manager_app/features/all_tickets/data/model/ticket_model/ticket_model/ticket_model.dart';

abstract class TicketRepo {
  Future<Either<Failure, List<TicketModel>>> fetchAllTickets();
  Future<Either<Failure, List<TicketModel>>> sortTicket({
    required String from,
    required String to,
    required int serviceId,
  });
}
