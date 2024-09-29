
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}
class FakeAuthState extends Fake implements AuthState {}

void main() {
	registerFallbackValue(FakeAuthState());

	group('HomeScreen Widget Tests', () {
		testWidgets('displays "Home Screen" text', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (context) => MockAuthCubit(),
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Home Screen'), findsOneWidget);
		});

		testWidgets('displays LogoutButton widget', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (context) => MockAuthCubit(),
						child: HomeScreen(),
					),
				),
			);

			expect(find.byType(LogoutButton), findsOneWidget);
		});
	});
}
