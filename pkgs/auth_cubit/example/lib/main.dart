import 'package:auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(
        providers: {
          EmailAuthProviderCubit(),
          PhoneAuthProviderCubit(),
        },
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use BlocBuilder to rebuild UI based on authentication state changes
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.when(
          unauthenticated: () => const LoginPage(),
          authenticated: (_) => const HomePage(),
        );
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Perform sign-in operation using email
                BlocProvider.of<AuthCubit>(context)
                    .provider<EmailAuthProviderCubit>()
                    .signIn(EmailAuthParams(
                        email: 'user@example.com', password: 'password123'));
              },
              child: const Text('Sign In with Email'),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform sign-in operation using phone number
                BlocProvider.of<AuthCubit>(context)
                    .provider<PhoneAuthProviderCubit>()
                    .signIn(PhoneAuthParams(phoneNumber: '+1234567890'));
              },
              child: const Text('Sign In with Phone'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('Welcome!'),
      ),
    );
  }
}

// Define EmailAuthProviderCubit and PhoneAuthProviderCubit
class EmailAuthProviderCubit extends AuthProviderCubit<EmailAuthParams> {
  EmailAuthProviderCubit() : super(const AuthProviderState.unauthenticated());

  @override
  Future<bool> signIn([EmailAuthParams? params]) async {
    // Add your sign-in logic here
    return true; // Placeholder return value
  }

  @override
  Future<bool> signOut() async {
    // Add your sign-out logic here
    return true; // Placeholder return value
  }

  @override
  Future<String?> accessToken() async {
    // Add your access token retrieval logic here
    return 'access_token'; // Placeholder return value
  }
}

class PhoneAuthProviderCubit extends AuthProviderCubit<PhoneAuthParams> {
  PhoneAuthProviderCubit() : super(const AuthProviderState.unauthenticated());

  @override
  Future<bool> signIn([PhoneAuthParams? params]) async {
    // Add your sign-in logic here
    return true; // Placeholder return value
  }

  @override
  Future<bool> signOut() async {
    // Add your sign-out logic here
    return true; // Placeholder return value
  }

  @override
  Future<String?> accessToken() async {
    // Add your access token retrieval logic here
    return 'access_token'; // Placeholder return value
  }
}

// Define AuthParams subclasses
class EmailAuthParams extends AuthProviderCubitParams {
  final String email;
  final String password;

  EmailAuthParams({required this.email, required this.password});
}

class PhoneAuthParams extends AuthProviderCubitParams {
  final String phoneNumber;

  PhoneAuthParams({required this.phoneNumber});
}
