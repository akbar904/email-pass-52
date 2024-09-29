
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/widgets/login_form.dart';
import 'package:simple_app/cubits/auth_cubit.dart';
import 'package:simple_app/cubits/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('renders email and password text fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider.value(
							value: authCubit,
							child: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
			expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
		});

		testWidgets('renders login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider.value(
							value: authCubit,
							child: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
		});

		testWidgets('calls login on AuthCubit when login button is tapped', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider.value(
							value: authCubit,
							child: LoginForm(),
						),
					),
				),
			);

			await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
			await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password');
			await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
			await tester.pump();

			verify(() => authCubit.login('test@example.com', 'password')).called(1);
		});
	});
}
