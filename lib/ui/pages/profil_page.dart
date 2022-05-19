import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_button.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Halaman Profil'),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: kRedColor,
                    content: Text(state.error),
                  ),
                );
              } else if (state is AuthInitial) {
                context.read<PageCubit>().setPage(0);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: CustomButton(
                    width: 200,
                    hintText: 'Log Out',
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
