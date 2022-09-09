import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/models/user_model.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UbahProfilForm extends StatelessWidget {
  final UserModel users;
  const UbahProfilForm(this.users, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${users.nama}'),
            TextButton(
              onPressed: () {
                context.read<PageCubit>().setPage(3);
                Navigator.pushReplacementNamed(context, '/main');
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
