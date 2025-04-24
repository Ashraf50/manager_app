import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:manager_app/core/constant/func/get_token.dart';
import 'package:manager_app/core/error/failure.dart';
import 'package:manager_app/core/helper/api_helper.dart';
import 'package:manager_app/features/all_tickets/data/model/ticket_model/ticket_model/ticket_model.dart';
import 'package:manager_app/features/all_tickets/data/repo/ticket_repo.dart';
import '../../../../core/constant/app_strings.dart';

class TicketRepoImpl implements TicketRepo {
  ApiHelper apiHelper;
  TicketRepoImpl(this.apiHelper);
  @override
  Future<List<TicketModel>> fetchAllTickets({int page = 1}) async {
    try {
      final token = await getToken();
      var response = await apiHelper.get(
        '${AppStrings.baseUrl}/api/managers/tickets?per_page=10',
        headers: {
          'Authorization': 'Bearer $token',
        },
        queryParameters: {'page': page},
      );
      var data = response.data;
      var ticketsList =
          (data["data"] as List).map((e) => TicketModel.fromJson(e)).toList();

      return ticketsList;
    } catch (e) {
      print("Error fetching tickets: $e");
      return [];
    }
  }

  @override
  Future<Either<Failure, List<TicketModel>>> sortTicket({
    required String from,
    required String to,
    required int serviceId,
  }) async {
    try {
      final token = await getToken();
      final queryParams = {
        'from': from,
        'to': to,
        'service_id': serviceId.toString(),
      };
      var response = await apiHelper.get(
        '${AppStrings.baseUrl}/api/managers/tickets',
        headers: {
          'Authorization': 'Bearer $token',
        },
        queryParameters: queryParams,
      );
      var data = response.data;
      var ticketsList =
          (data["data"] as List).map((e) => TicketModel.fromJson(e)).toList();
      return Right(ticketsList);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> assignTicket({
    required int ticketId,
    required int ticketianId,
  }) async {
    try {
      final token = await getToken();
      await apiHelper.post(
        '${AppStrings.baseUrl}/api/managers/tickets/$ticketId/assign',
        {
          "technician_id": ticketianId,
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return const Right(unit);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> finishTicket({required int ticketId}) async {
    try {
      final token = await getToken();
      await apiHelper.post(
        '${AppStrings.baseUrl}/api/managers/tickets/$ticketId/finish',
        null,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return const Right(unit);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
