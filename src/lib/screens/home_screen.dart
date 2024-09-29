
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/logout_button.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

class HomeScreen extends StatelessWidget {
	const HomeScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Home Screen'),
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						const Text('Home Screen'),
						const SizedBox(height: 20),
						LogoutButton(),
					],
				),
			),
		);
	}
}
