import 'package:dartz/dartz.dart';
import 'package:api_contracts/api_contracts.dart';
import 'package:core/core.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Unit>> createUser({
    required String id,
    required String email,
    required String name,
    String? countryCode,
    String? defaultCurrencyCode,
  }) async {
    try {
      final request = CreateUserRequest()
        ..id = id
        ..email = email
        ..name = name
        ..countryCode = countryCode ?? ''
        ..defaultCurrencyCode = defaultCurrencyCode ?? '';
      
      await remoteDataSource.createUser(request);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
