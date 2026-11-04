import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/pembeli_home_screen.dart';
import 'services/cart_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CartService.instance.clearCart();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const PembeliApp());
}

class PembeliApp extends StatelessWidget {
  const PembeliApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF01A852);

    return MaterialApp(
      title: 'My Big Grocery - Pembeli',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandGreen,
          primary: brandGreen,
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const PembeliAppRoot(),
    );
  }
}

enum AppStep {
  splash,
  onboarding,
  login,
  register,
  forgotPassword,
  homePembeli,
}

class PembeliAppRoot extends StatefulWidget {
  const PembeliAppRoot({super.key});

  @override
  State<PembeliAppRoot> createState() => _PembeliAppRootState();
}

class _PembeliAppRootState extends State<PembeliAppRoot> {
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
      _step = AppStep.homePembeli;
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
        return PembeliSplashScreen(onFinished: _finishSplash);
      case AppStep.onboarding:
        return OnboardingScreen(onSkip: _goToLogin);
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
        return ForgotPasswordScreen(onBackToLogin: _goToLogin);
      case AppStep.homePembeli:
        return PembeliHomeScreen(onLogout: _handleLogout);
    }
  }
}
