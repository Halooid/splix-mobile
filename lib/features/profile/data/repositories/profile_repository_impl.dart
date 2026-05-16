import 'package:dartz/dartz.dart';
import 'package:api_contracts/api_contracts.dart';
import 'package:core/core.dart';
import 'package:grpc/grpc.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/user_entity.dart';
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

  @override
  Future<Either<Failure, UserEntity>> getUser(String id) async {
    try {
      final request = GetUserRequest()..id = id;
      final response = await remoteDataSource.getUser(request);
      
      return Right(UserEntity(
        id: response.user.id,
        email: response.user.email,
        name: response.user.name,
        countryCode: response.user.countryCode,
        defaultCurrencyCode: response.user.defaultCurrencyCode,
        createdAt: response.user.createdAt.toDateTime(),
      ));
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        return const Left(NotFoundFailure('User not found'));
      }
      return Left(ServerFailure(e.message ?? e.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
