
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';
import 'package:com.example.simple_app/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
	const LoginScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: BlocConsumer<AuthCubit, AuthState>(
				listener: (context, state) {
					if (state is AuthError) {
						ScaffoldMessenger.of(context).showSnackBar(
							SnackBar(content: Text(state.message)),
						);
					}
				},
				builder: (context, state) {
					if (state is AuthLoading) {
						return Center(child: CircularProgressIndicator());
					} else {
						return LoginForm();
					}
				},
			),
		);
	}
}
