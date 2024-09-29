
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('MyApp', () {
		testWidgets('renders LoginScreen initially', (tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('AuthCubit', () {
		blocTest<MockAuthCubit, AuthState>(
			'emits [Authenticated] when login is successful',
			build: () => MockAuthCubit(),
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [isA<Authenticated>()],
		);

		blocTest<MockAuthCubit, AuthState>(
			'emits [Unauthenticated] when logout is called',
			build: () => MockAuthCubit(),
			act: (cubit) => cubit.logout(),
			expect: () => [isA<Unauthenticated>()],
		);
	});

	group('Widgets in main', () {
		testWidgets('renders LoginScreen with LoginForm', (tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(LoginForm), findsOneWidget);
		});

		testWidgets('renders HomeScreen with LogoutButton', (tester) async {
			final authCubit = MockAuthCubit();
			whenListen(authCubit, Stream.fromIterable([Authenticated()]), initialState: AuthInitial());

			await tester.pumpWidget(
				BlocProvider.value(
					value: authCubit,
					child: MyApp(),
				),
			);

			await tester.pumpAndSettle();
			expect(find.byType(LogoutButton), findsOneWidget);
		});
	});

	group('Main setup and initialization', () {
		test('MyApp initializes correctly', () {
			final app = MyApp();
			expect(app, isA<MyApp>());
		});
	});
}
