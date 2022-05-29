import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ft_uim_naive_bayes/models/user_model.dart';
import 'package:ft_uim_naive_bayes/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void register({
    required String stambuk,
    required String nama,
    required String gender,
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().register(
        stambuk: stambuk,
        nama: nama,
        gender: gender,
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signIn({
    required String stambuk,
    required String password,
  }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().signIn(
        stambuk: stambuk,
        password: password,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {}
  }

  void getProfil() async {
    try {
      UserModel? user = await AuthService().getProfil();
      emit(AuthSuccess(user!));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void autoLogout() async {
    try {
      emit(AuthLoading());
      AuthService().autoLogOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  // void refreshToken() async {
  //   try {
  //     await AuthService().refreshToken();
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
}
