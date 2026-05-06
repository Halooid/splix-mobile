import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get grpcHost => dotenv.get('GRPC_HOST', fallback: 'localhost');
  
  static int get grpcPort => int.parse(dotenv.get('GRPC_PORT', fallback: '443'));
  
  static bool get grpcSecure => dotenv.get('GRPC_SECURE', fallback: grpcPort == 443 ? 'true' : 'false').toLowerCase() == 'true';
  
  static String get authClientId => dotenv.get('AUTH_CLIENT_ID', fallback: 'splix-mobile');
  
  static String get authRedirectUri => dotenv.get('AUTH_REDIRECT_URI', fallback: 'com.halooid.splix.mobile://oauth/callback');
  
  static String get authDiscoveryUrl => dotenv.get('AUTH_DISCOVERY_URL', fallback: 'https://auth.droprit.com/realms/halooid/.well-known/openid-configuration');
}
