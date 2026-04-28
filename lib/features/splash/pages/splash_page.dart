import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:auth/auth.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/powered_by_halooid.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Color _color1 = AppTheme.backgroundColor;
  Color _color2 = AppTheme.accentColor;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _color1 = AppTheme.accentColor;
          _color2 = AppTheme.secondaryColor;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        Future.delayed(const Duration(seconds: 2), () {
          if (!context.mounted) return;
          if (state is AuthAuthenticated) {
            context.go('/dashboard');
          } else if (state is AuthUnauthenticated || state is AuthFailureState) {
            context.go('/auth');
          }
        });
      },
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(seconds: 2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_color1, _color2],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/app-logo.png',
                        width: 150,
                        height: 150,
                      ),
                      Text(
                        'Splix',
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge?.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const PoweredByHalooid(logoColor: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
