part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginChangeRememberMeState extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginNotLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {}
class LoginErrorState extends LoginState {
  String msg;
  LoginErrorState ({required this.msg});
}

