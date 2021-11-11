part of 'auth_bloc.dart';

enum AuthStatus { loggedIn, loggedOut, loading }

abstract class AuthState extends Equatable {
  final AuthStatus currentStatus;

  const AuthState(this.currentStatus);
}

class LoggedInState extends AuthState {
  const LoggedInState() : super(AuthStatus.loggedIn);

  @override
  List<Object?> get props => [currentStatus];
}

class LoggedOutState extends AuthState {
  const LoggedOutState() : super(AuthStatus.loggedOut);

  @override
  List<Object?> get props => [currentStatus];
}
