import 'dart:ui';
import 'package:core/core.dart';
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
import '../../profile/domain/usecases/get_user_usecase.dart';

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
          final payload = JwtUtils.decode(state.idToken!);
          final userId = payload['sub'] as String? ?? '';

          if (_isRegistering && state.idToken != null) {
            try {
              final createUserUseCase = getIt<CreateUserUseCase>();
              final result = await createUserUseCase(
                CreateUserParams(
                  id: userId,
                  email: payload['email'] as String? ?? '',
                  name:
                      payload['name'] as String? ??
                      payload['preferred_username'] as String? ??
                      '',
                ),
              );

              result.fold(
                (failure) {
                  debugPrint('Failed to create splix user: ${failure.message}');
                  if (context.mounted) {
                    setState(() => _isRegistering = false);
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to initialize Splix account: ${failure.message}',
                        ),
                      ),
                    );
                  }
                },
                (_) {
                  if (context.mounted) {
                    context.go('/dashboard');
                  }
                },
              );
            } catch (e) {
              debugPrint('Unexpected error creating splix user: $e');
              if (context.mounted) {
                setState(() => _isRegistering = false);
                context.read<AuthBloc>().add(AuthLogoutRequested());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'An unexpected error occurred. Please try again.',
                    ),
                  ),
                );
              }
            }
          } else {
            // Check if user exists in Splix DB
            try {
              final getUserUseCase = getIt<GetUserUseCase>();
              final result = await getUserUseCase(GetUserParams(id: userId));

              result.fold(
                (failure) {
                  if (failure is NotFoundFailure) {
                    // User not found, redirect to registration
                    if (context.mounted) {
                      setState(() => _isRegistering = true);
                      context.read<AuthBloc>().add(AuthRegisterRequested());
                    }
                  } else {
                    // Server error or other failure, fail authentication
                    debugPrint(
                      'Server error checking user: ${failure.message}',
                    );
                    if (context.mounted) {
                      setState(() => _isRegistering = false);
                      context.read<AuthBloc>().add(AuthLogoutRequested());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Error checking account status: ${failure.message}',
                          ),
                        ),
                      );
                    }
                  }
                },
                (user) {
                  // User exists, proceed to dashboard
                  if (context.mounted) {
                    context.go('/dashboard');
                  }
                },
              );
            } catch (e) {
              debugPrint('Unexpected error checking user: $e');
              if (context.mounted) {
                setState(() => _isRegistering = false);
                context.read<AuthBloc>().add(AuthLogoutRequested());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'An unexpected error occurred. Please try again.',
                    ),
                  ),
                );
              }
            }
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium?.copyWith(
                                      color: AppTheme.primaryColor,
                                    ),
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
