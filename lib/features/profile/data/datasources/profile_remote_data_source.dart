import 'package:api_contracts/api_contracts.dart';

abstract class ProfileRemoteDataSource {
  Future<CreateUserResponse> createUser(CreateUserRequest request);
  Future<GetUserResponse> getUser(GetUserRequest request);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final UserServiceClient client;

  ProfileRemoteDataSourceImpl(this.client);

  @override
  Future<CreateUserResponse> createUser(CreateUserRequest request) async {
    return await client.createUser(request);
  }

  @override
  Future<GetUserResponse> getUser(GetUserRequest request) async {
    return await client.getUser(request);
  }
}
