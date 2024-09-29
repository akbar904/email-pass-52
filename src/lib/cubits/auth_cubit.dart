
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app/cubits/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) {
		emit(AuthInitial());
		// Assume login is always successful for simplicity
		emit(Authenticated());
	}

	void logout() {
		emit(Authenticated());
		emit(Unauthenticated());
	}
}
