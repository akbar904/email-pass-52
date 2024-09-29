
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_app/cubits/auth_cubit.dart';
import 'package:your_app/cubits/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		test('initial state is AuthInitial', () {
			expect(authCubit.state, AuthInitial());
		});

		blocTest<AuthCubit, AuthState>(
			'login emits [AuthInitial, Authenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [AuthInitial(), Authenticated()],
		);

		blocTest<AuthCubit, AuthState>(
			'logout emits [Authenticated, Unauthenticated]',
			build: () => authCubit,
			seed: () => Authenticated(),
			act: (cubit) => cubit.logout(),
			expect: () => [Authenticated(), Unauthenticated()],
		);
	});
}
