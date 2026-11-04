import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/penjual_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const PenjualApp());
}

class PenjualApp extends StatelessWidget {
  const PenjualApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF01A852);

    return MaterialApp(
      title: 'My Big Grocery - Penjual',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandGreen,
          primary: brandGreen,
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const PenjualAppRoot(),
    );
  }
}

enum AppStep { splash, onboarding, login, register, forgotPassword, homePenjual }

class PenjualAppRoot extends StatefulWidget {
  const PenjualAppRoot({super.key});

  @override
  State<PenjualAppRoot> createState() => _PenjualAppRootState();
}

class _PenjualAppRootState extends State<PenjualAppRoot> {
  AppStep _step = AppStep.splash;

  void _finishSplash() {
    setState(() {
      _step = AppStep.onboarding;
    });
  }

  void _goToLogin() {
    setState(() {
      _step = AppStep.login;
    });
  }

  void _goToRegister() {
    setState(() {
      _step = AppStep.register;
    });
  }

  void _goToForgotPassword() {
    setState(() {
      _step = AppStep.forgotPassword;
    });
  }

  void _backToOnboarding() {
    setState(() {
      _step = AppStep.onboarding;
    });
  }

  void _handleLoginSuccess() {
    setState(() {
      _step = AppStep.homePenjual;
    });
  }

  void _handleLogout() {
    setState(() {
      _step = AppStep.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case AppStep.splash:
        return PenjualSplashScreen(
          onFinished: _finishSplash,
        );
      case AppStep.onboarding:
        return OnboardingScreen(
          onSkip: _goToLogin,
        );
      case AppStep.login:
        return LoginScreen(
          onBackToOnboarding: _backToOnboarding,
          onGoToRegister: _goToRegister,
          onGoToForgotPassword: _goToForgotPassword,
          onLoginSuccess: _handleLoginSuccess,
        );
      case AppStep.register:
        return RegisterScreen(
          onGoToLogin: _goToLogin,
          onLoginSuccess: _handleLoginSuccess,
        );
      case AppStep.forgotPassword:
        return ForgotPasswordScreen(
          onBackToLogin: _goToLogin,
        );
      case AppStep.homePenjual:
        return PenjualHomeScreen(
          onLogout: _handleLogout,
        );
    }
  }
}
