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
    required String prodi,
    required String gender,
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().register(
        stambuk: stambuk,
        nama: nama,
        prodi: prodi,
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
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
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

  void checkPassword({
    required String idUser,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel userPassword = await AuthService().checkPassword(
        idUser: idUser,
        password: password,
      );
      emit(AuthSuccess(userPassword));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void updatePassword({
    required String idUser,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel users = await AuthService()
          .updatePassword(idUser: idUser, password: password);
      emit(AuthSuccess(users));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void editUser({
    required String idUser,
    required String nama,
    required String stambuk,
    required String prodi,
    required String gender,
    required String email,
  }) async {
    try {
      emit(AuthLoading());
      UserModel users = await AuthService().editUser(
        idUser: idUser,
        nama: nama,
        stambuk: stambuk,
        prodi: prodi,
        gender: gender,
        email: email,
      );

      emit(AuthSuccess(users));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
