import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomFormInput extends StatelessWidget {
  final String title;
  final bool obSecureText;
  final TextEditingController controller;

  CustomFormInput({
    Key? key,
    required this.title,
    this.obSecureText = false,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackTextStyle.copyWith(),
          ),
          SizedBox(height: 6),
          TextFormField(
            obscureText: obSecureText,
            cursorColor: kBlackColor,
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Data tidak boleh kosong.";
              }
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(color: kBlackColor)),
                focusColor: kBlackColor),
          )
        ],
      ),
    );
  }
}
