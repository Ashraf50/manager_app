import 'package:dartz/dartz.dart';
import 'package:manager_app/core/error/failure.dart';
import 'package:manager_app/features/add_ticketian/data/model/ticketian_model/ticketian_model.dart';

abstract class TicketianRepo {
  Future<Either<Failure, List<TicketianModel>>> fetchAllTicketian();

  Future<Either<Failure, List<TicketianModel>>> searchTicketian(
      {required String name});
  Future<Either<Failure, Unit>> deleteTicketian(int id);
  Future<Either<Failure, Unit>> editTicketian({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPass,
  });
  Future<Either<Failure, Unit>> createTicketian({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPass,
  });
}
