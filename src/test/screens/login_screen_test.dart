
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/screens/login_screen.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';

// Mock classes
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}
class FakeAuthState extends Fake implements AuthState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthState());
  });

  group('LoginScreen Widget Tests', () {
    testWidgets('LoginScreen shows login form', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => MockAuthCubit(),
            child: LoginScreen(),
          ),
        ),
      );

      // Verify that the LoginScreen displays the login form.
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('LoginScreen shows loading indicator when state is loading',
        (WidgetTester tester) async {
      final mockAuthCubit = MockAuthCubit();

      whenListen(
        mockAuthCubit,
        Stream.fromIterable([AuthInitial(), AuthLoading()]),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockAuthCubit,
            child: LoginScreen(),
          ),
        ),
      );

      // Pump the widget to ensure all the streams are processed
      await tester.pump();

      // Verify that the loading indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('LoginScreen shows error message when state is error',
        (WidgetTester tester) async {
      final mockAuthCubit = MockAuthCubit();

      whenListen(
        mockAuthCubit,
        Stream.fromIterable([AuthInitial(), AuthError('Login failed')]),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => mockAuthCubit,
            child: LoginScreen(),
          ),
        ),
      );

      // Pump the widget to ensure all the streams are processed
      await tester.pump();

      // Verify that the error message is shown
      expect(find.text('Login failed'), findsOneWidget);
    });
  });
}
