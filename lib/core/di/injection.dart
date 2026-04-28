import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:auth/auth.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Config
  final authConfig = AuthConfig(
    clientId: 'splix-mobile',
    redirectUri: 'com.halooid.splix.mobile://oauth/callback',
    discoveryUrl: 'https://auth.droprit.com/realms/halooid/.well-known/openid-configuration',
  );

  // Services
  getIt.registerLazySingleton<AuthService>(() => AuthService(authConfig));
  getIt.registerLazySingleton<TokenRepository>(() => TokenRepository());

  // Blocs
  getIt.registerFactory<AuthBloc>(() => AuthBloc(
    authService: getIt<AuthService>(),
    tokenRepository: getIt<TokenRepository>(),
  ));
}
