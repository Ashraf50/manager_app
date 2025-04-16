import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../model/user_model/user_model.dart';

abstract class UserRepo {
  Future<Either<Failure, UserModel>> fetchUserData({
    required String token,
  });
  Future<Either<Failure, UserModel>> updateData({
    required String name,
    required String email,
    required String phone,
    required File avatar,
  });
}
