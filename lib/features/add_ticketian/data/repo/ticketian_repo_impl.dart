import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:manager_app/core/constant/app_strings.dart';
import 'package:manager_app/core/constant/func/get_token.dart';
import 'package:manager_app/core/error/failure.dart';
import 'package:manager_app/core/helper/api_helper.dart';
import 'package:manager_app/features/add_ticketian/data/model/ticketian_model/ticketian_model.dart';
import 'package:manager_app/features/add_ticketian/data/repo/ticketian_repo.dart';

class TicketianRepoImpl implements TicketianRepo {
  ApiHelper apiHelper;
  TicketianRepoImpl(this.apiHelper);
  @override
  Future<Either<Failure, Unit>> createTicketian({
    required String name,
    required String email,
    required String password,
    required String confirmPass,
    required String phone,
  }) async {
    try {
      final token = await getToken();
      await apiHelper.post(
        '${AppStrings.baseUrl}/api/managers/technicians',
        {
          "name": name,
          "email": email,
          'phone': phone,
          "password": password,
          "password_confirmation": confirmPass,
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
  Future<Either<Failure, Unit>> deleteTicketian(int id) async {
    try {
      final token = await getToken();
      await apiHelper.delete(
        '${AppStrings.baseUrl}/api/managers/technicians/$id',
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
  Future<Either<Failure, Unit>> editTicketian({
    required int id,
    required String name,
    required String email,
    required String password,
    required String confirmPass,
    required String phone,
  }) async {
    try {
      final token = await getToken();
      final data = {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmPass,
      };
      await apiHelper.put(
        '${AppStrings.baseUrl}/api/managers/technicians/$id',
        data,
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
  Future<Either<Failure, List<TicketianModel>>> fetchAllTicketian() async {
    try {
      final token = await getToken();
      var response = await apiHelper.get(
        '${AppStrings.baseUrl}/api/managers/technicians',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      var data = response.data;
      var ticketianList = (data["data"] as List)
          .map((e) => TicketianModel.fromJson(e))
          .toList();
      return Right(ticketianList);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TicketianModel>>> searchTicketian(
      {required String name}) async {
    try {
      final token = await getToken();
      final response = await apiHelper.get(
        '${AppStrings.baseUrl}/api/managers/technicians?handle=$name',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      var data = response.data;
      var ticketianList = (data["data"] as List)
          .map((e) => TicketianModel.fromJson(e))
          .toList();
      return Right(ticketianList);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
