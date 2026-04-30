import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../repositories/profile_repository.dart';

class CreateUserUseCase {
  final ProfileRepository repository;

  CreateUserUseCase(this.repository);

  Future<Either<Failure, Unit>> call(CreateUserParams params) async {
    return await repository.createUser(
      id: params.id,
      email: params.email,
      name: params.name,
      countryCode: params.countryCode,
      defaultCurrencyCode: params.defaultCurrencyCode,
    );
  }
}

class CreateUserParams {
  final String id;
  final String email;
  final String name;
  final String? countryCode;
  final String? defaultCurrencyCode;

  CreateUserParams({
    required this.id,
    required this.email,
    required this.name,
    this.countryCode,
    this.defaultCurrencyCode,
  });
}
