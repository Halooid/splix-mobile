import 'package:get_it/get_it.dart';
import 'package:auth/auth.dart';
import 'package:api_contracts/api_contracts.dart';
import 'package:grpc/grpc.dart';
import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/create_user_usecase.dart';
import '../../features/profile/domain/usecases/get_user_usecase.dart';
import '../config/env_config.dart';


final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Network (gRPC)
  final channel = ClientChannel(
    EnvConfig.splixHost,
    port: EnvConfig.servicePort,
    options: ChannelOptions(
      credentials: EnvConfig.serviceSecure
          ? const ChannelCredentials.secure()
          : const ChannelCredentials.insecure(),
    ),
  );
  getIt.registerLazySingleton<ClientChannel>(() => channel);
  getIt.registerLazySingleton<UserServiceClient>(
    () => UserServiceClient(getIt<ClientChannel>()),
  );

  // Config
  final authConfig = AuthConfig(
    clientId: EnvConfig.authClientId,
    redirectUri: EnvConfig.authRedirectUri,
    discoveryUrl: EnvConfig.authDiscoveryUrl,
  );

  // Services
  getIt.registerLazySingleton<AuthService>(() => AuthService(authConfig));
  getIt.registerLazySingleton<TokenRepository>(() => TokenRepository());

  // Data Sources
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(getIt<UserServiceClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: getIt<ProfileRemoteDataSource>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<CreateUserUseCase>(
    () => CreateUserUseCase(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton<GetUserUseCase>(
    () => GetUserUseCase(getIt<ProfileRepository>()),
  );

  // Blocs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      authService: getIt<AuthService>(),
      tokenRepository: getIt<TokenRepository>(),
    ),
  );
}
