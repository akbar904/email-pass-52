
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:your_project_name/models/user.dart';

void main() {
	group('User Model', () {
		test('should create a User instance', () {
			final user = User(email: 'test@example.com', password: 'password123');
			expect(user.email, 'test@example.com');
			expect(user.password, 'password123');
		});

		test('should serialize User to JSON', () {
			final user = User(email: 'test@example.com', password: 'password123');
			final json = user.toJson();
			expect(json, {
				'email': 'test@example.com',
				'password': 'password123',
			});
		});

		test('should deserialize User from JSON', () {
			final json = {
				'email': 'test@example.com',
				'password': 'password123',
			};
			final user = User.fromJson(json);
			expect(user.email, 'test@example.com');
			expect(user.password, 'password123');
		});
	});
}

class User {
	final String email;
	final String password;

	User({required this.email, required this.password});

	Map<String, dynamic> toJson() {
		return {
			'email': email,
			'password': password,
		};
	}

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			email: json['email'],
			password: json['password'],
		);
	}
}
