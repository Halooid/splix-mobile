import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get authHost => dotenv.get('AUTH_HOST');
  static String get lookupHost => dotenv.get('LOOKUP_HOST');
  static String get splixHost => dotenv.get('SPLIX_HOST');
  
  static int get servicePort => int.parse(dotenv.get('SERVICE_PORT'));
  
  static bool get serviceSecure => dotenv.get('SERVICE_SECURE').toLowerCase() == 'true';
  
  static String get authClientId => dotenv.get('AUTH_CLIENT_ID');
  
  static String get authRedirectUri => dotenv.get('AUTH_REDIRECT_URI');
  
  static String get authDiscoveryUrl => dotenv.get('AUTH_DISCOVERY_URL');
}
