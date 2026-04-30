import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:auth/auth.dart';
import 'package:lottie/lottie.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/powered_by_halooid.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/jwt_utils.dart';
import '../../profile/domain/usecases/create_user_usecase.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthAuthenticated) {
          if (_isRegistering && state.idToken != null) {
            try {
              final payload = JwtUtils.decode(state.idToken!);
              final createUserUseCase = getIt<CreateUserUseCase>();
              
              await createUserUseCase(CreateUserParams(
                id: payload['sub'] as String? ?? '',
                email: payload['email'] as String? ?? '',
                name: payload['name'] as String? ?? payload['preferred_username'] as String? ?? '',
              ));
            } catch (e) {
              // Silently fail or log, user is already authenticated in Keycloak
              debugPrint('Failed to create splix user: $e');
            }
          }
          if (context.mounted) {
            context.go('/dashboard');
          }
        } else if (state is AuthFailureState) {
          setState(() => _isRegistering = false);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [AppTheme.backgroundColor, AppTheme.accentColor],
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(height: 48),
                              Lottie.asset(
                                'assets/json/illustration-login.json',
                                height: 250,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Track it. Split it.\nForget it.',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                            color: AppTheme.primaryColor),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'All your expenses, organized and under control',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.black87),
                                  ),
                                  const SizedBox(height: 48),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() => _isRegistering = false);
                                      context.read<AuthBloc>().add(
                                            AuthLoginRequested(),
                                          );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50),
                                    ),
                                    child: const Text('Login'),
                                  ),
                                  const SizedBox(height: 16),
                                  OutlinedButton(
                                    onPressed: () {
                                      setState(() => _isRegistering = true);
                                      context.read<AuthBloc>().add(
                                            AuthRegisterRequested(),
                                          );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50),
                                    ),
                                    child: const Text('Register'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const PoweredByHalooid(logoColor: Colors.black),
                    ],
                  ),
                ),
                if (state is AuthLoading)
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        color: Colors.black.withAlpha(50),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
