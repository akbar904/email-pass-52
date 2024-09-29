
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/cubits/auth_cubit.dart';

class LoginForm extends StatelessWidget {
	const LoginForm({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final _formKey = GlobalKey<FormState>();
		final TextEditingController _emailController = TextEditingController();
		final TextEditingController _passwordController = TextEditingController();

		return Form(
			key: _formKey,
			child: Column(
				children: <Widget>[
					TextFormField(
						controller: _emailController,
						decoration: InputDecoration(labelText: 'Email'),
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Please enter your email';
							}
							return null;
						},
					),
					TextFormField(
						controller: _passwordController,
						decoration: InputDecoration(labelText: 'Password'),
						obscureText: true,
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Please enter your password';
							}
							return null;
						},
					),
					ElevatedButton(
						onPressed: () {
							if (_formKey.currentState?.validate() ?? false) {
								BlocProvider.of<AuthCubit>(context).login(
									_emailController.text,
									_passwordController.text,
								);
							}
						},
						child: Text('Login'),
					),
				],
			),
		);
	}
}
