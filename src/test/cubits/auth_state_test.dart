
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';

void main() {
	group('AuthState', () {
		test('AuthState should be abstract', () {
			expect(AuthState, isAbstract);
		});
		
		test('AuthInitial should be a subclass of AuthState', () {
			expect(AuthInitial(), isA<AuthState>());
		});
		
		test('Authenticated should be a subclass of AuthState', () {
			expect(Authenticated(), isA<AuthState>());
		});
		
		test('Unauthenticated should be a subclass of AuthState', () {
			expect(Unauthenticated(), isA<AuthState>());
		});
	});
}
