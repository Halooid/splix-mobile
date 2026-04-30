import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Unit>> createUser({
    required String id,
    required String email,
    required String name,
    String? countryCode,
    String? defaultCurrencyCode,
  });
}
