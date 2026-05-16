import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class GetUserUseCase {
  final ProfileRepository repository;

  GetUserUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(GetUserParams params) async {
    return await repository.getUser(params.id);
  }
}

class GetUserParams {
  final String id;

  GetUserParams({required this.id});
}
