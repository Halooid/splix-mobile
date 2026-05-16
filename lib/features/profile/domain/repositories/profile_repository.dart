import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Unit>> createUser({
    required String id,
    required String email,
    required String name,
    String? countryCode,
    String? defaultCurrencyCode,
  });

  Future<Either<Failure, UserEntity>> getUser(String id);
}
