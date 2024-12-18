import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_authLoginRequested);

    on<AuthLogoutRequested>(_authLogoutRequested);
  }

  void _authLoginRequested(event, emit) async {
    final email = event.email;
    final password = event.password;
    emit(AuthLoading());
    try {
      if (password.length < 6) {
        emit(AuthFailure('the password should be greater than 6 characters'));
        return;
      }

      await Future.delayed(const Duration(seconds: 1), () {
        return emit(AuthSuccess('$email-$password'));
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _authLogoutRequested(event, emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
