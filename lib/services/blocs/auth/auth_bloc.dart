import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const LoggedOutState()) {
    on<LoginEvent>(_onLoginEventReceived);
    on<LogoutEvent>(_onLogoutEventReceived);
  }

  void _onLoginEventReceived(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (event.email == 'jd') {
      emit(const LoggedInState());
      print('logged');
    }
  }

  void _onLogoutEventReceived(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const LoggedOutState());
  }
}
