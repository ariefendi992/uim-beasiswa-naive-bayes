import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/ui/pages/penerima_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/uji_page.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_menu_beasiswa.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
// import 'package:ft_uim_naive_bayes/utils/extensions.dart';

class BeasiswaPage extends StatelessWidget {
  const BeasiswaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: defaultPadding,
            right: defaultPadding,
            top: 20,
          ),
          child: Text(
            ''.toUpperCase(),
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: medium,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: defaultPadding,
            right: defaultPadding,
            top: 10,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PenerimaPage(),
                    ),
                  );
                },
                child: CustomMenuBeasiswa(
                  icon: Icons.list_alt,
                  title: 'Data Training'.toUpperCase(),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UjiPage(),
                    ),
                  );
                },
                child: CustomMenuBeasiswa(
                  icon: Icons.app_registration_sharp,
                  title: 'Data Testing'.toUpperCase(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
